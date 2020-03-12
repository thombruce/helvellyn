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

  def dynamic_attributes
    content_type.dynamic_attributes
  end

  # TODO: Review below
  def method_missing(method_name, *arguments, &block)
    if dynamic_attributes.include?(method_name)
      self.data[method_name]
    elsif dynamic_attributes.map { |attr| "#{attr}=" }.include?(method_name.to_s)
      self.data[method_name.to_s.chomp('=').to_sym] = arguments.first
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    dynamic_attributes.map { |attr| ["#{attr}", "#{attr}="] }.flatten.include?(method_name.to_s) || super
  end
end
