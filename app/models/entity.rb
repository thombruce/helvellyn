class Entity < ApplicationRecord
  extend FriendlyId

  resourcify

  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at < ?', DateTime.now) }

  belongs_to :template

  # TODO: Associated to user via :author role. But if user leaves app, :author becomes
  #       empty. Maybe an optional Author type field that stores key info... indefinitely.
  #       Perhaps. Something to maybe be added to template models: Author field_type
  #       that would... associate some author with the entity.

  friendly_id :dynamic_slug_field, use: [:slugged, :scoped], scope: :template

  serialize :data, HashSerializer

  validates :data, presence: true #, content_entry: { schema: template.fields }

  serialize :generated_fields, HashSerializer

  validates_presence_of :slug
  validates_uniqueness_of :slug, scope: :template
  validates_format_of :slug, with: /\A(?:[a-z0-9][_-]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers, dashes and underscores (e.g. my_slug-1)'
  validates_format_of :slug, without: /\A\d+\Z/, message: 'cannot contain only numbers'

  # TODO: We essentially have a frontend validation of whether content is publishable right now.
  #       We should validate here to see that the template is publishable to prevent
  #       non-publishable content types from becoming public.

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
    if sluggable_field = template.fields.find { |dg| dg[:sluggable] }
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
    template.dynamic_attributes
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

# Legacy

# def method_missing(method_name, *arguments, &block)
#   if key = find_getter(method_name)
#     self.data[key]
#   elsif key = find_setter(method_name)
#     # TODO: Review this code.
#     field_type = template.fields.find { |field| field[:slug] == key.to_s }[:type]
#     if field_type == 'Markdown'
#       self.generated_fields[key.to_s + '_as_html'] =
#         Redcarpet::Markdown.new(
#           HelvellynRenderer,
#           no_intra_emphasis: true,
#           tables: true,
#           fenced_code_blocks: true,
#           strikethrough: true
#         ).render(arguments.first)
#     end
#     self.data[key] = arguments.first
#   else
#     super
#   end
# end
