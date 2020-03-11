class ContentEntry < ApplicationRecord
  belongs_to :content_type

  def draft
    !self.published_at
  end

  def published
    !draft
  end

  def publish=(publish)
    if draft && publish
      self.published_at = DateTime.now
    elsif published && !publish
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
      self.data ||= {}
      self.data[method_name]
    elsif dynamic_attributes.map { |attr| "#{attr}=" }.include?(method_name.to_s)
      self.data ||= {}
      self.data[method_name.to_s.chomp('=').to_sym] = arguments.first
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    dynamic_attributes.map { |attr| ["#{attr}", "#{attr}="] }.flatten.include?(method_name.to_s) || super
  end
end
