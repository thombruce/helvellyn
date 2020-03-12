class ContentEntry < ApplicationRecord
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where('published_at < ?', DateTime.now) }

  belongs_to :content_type

  serialize :data, HashSerializer

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
