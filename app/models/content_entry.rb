class ContentEntry < ApplicationRecord
  extend FriendlyId

  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at < ?', DateTime.now) }

  belongs_to :content_type

  friendly_id :dynamic_slug_field, use: [:slugged, :scoped], scope: :content_type

  serialize :data, HashSerializer
  serialize :generated_fields, HashSerializer

  validates_presence_of :slug
  validates_uniqueness_of :slug, scope: :content_type
  validates_format_of :slug, with: /\A(?:[a-z0-9][_-]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers, dashes and underscores (e.g. my_slug-1)'
  validates_format_of :slug, without: /\A\d+\Z/, message: 'cannot contain only numbers'

  def draft?
    !self.published_at
  end
  alias_method :draft, :draft?

  def published?
    !self.draft?
  end
  alias_method :published, :published?

  def publish=(publish)
    if self.draft? && publish
      self.published_at = DateTime.now
    elsif self.published? && !publish
      self.published_at = nil
    end
  end
  alias_method :published=, :publish=

  def method_missing(method_name, *arguments, &block)
    if key = find_getter(method_name)
      self.data[key]
    elsif key = find_setter(method_name)
      # TODO: Review this code.
      field_type = content_type.fields.find { |field| field[:slug] == key.to_s }[:type]
      if field_type == 'Markdown'
        self.generated_fields[key.to_s + '_as_html'] =
          Redcarpet::Markdown.new(
            HelvellynRenderer,
            no_intra_emphasis: true,
            tables: true,
            fenced_code_blocks: true,
            strikethrough: true
          ).render(arguments.first)
      end
      self.data[key] = arguments.first
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    dynamic_methods.include?(method_name) || super
  end

  private

  def dynamic_slug_field
    if sluggable_field = content_type.fields.find { |dg| dg[:sluggable] }
      slug_field = sluggable_field[:slug]
      data[slug_field]
    else
      SecureRandom.uuid
    end
  end

  def dynamic_methods
    dynamic_getters + dynamic_setters
  end

  def dynamic_getters
    content_type.dynamic_attributes
  end

  def dynamic_setters
    dynamic_getters.map { |attr| "#{attr}=".to_sym }
  end

  def find_getter(method_name)
    dynamic_getters.find { |dg| dg == method_name }
  end

  def find_setter(method_name)
    dynamic_setters.find { |ds| ds == method_name }.to_s.chomp('=').to_sym
  end
end
