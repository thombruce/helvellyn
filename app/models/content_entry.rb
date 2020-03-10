class ContentEntry < ApplicationRecord
  belongs_to :workspace
  belongs_to :content_type

  def dynamic_attributes
    content_type.sanitized_fields.map { |field| field[:slug].to_sym }
  end

  def method_missing(method_name, *arguments, &block)
    if dynamic_attributes.map { |attr| "#{attr}=" }.include?(method_name.to_s)
      self.data ||= {}
      self.data[method_name.to_s.chomp('=').to_sym] = arguments.first
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    dynamic_attributes.map { |attr| "#{attr}=" }.include?(method_name.to_s) || super
  end
end
