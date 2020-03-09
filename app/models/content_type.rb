class ContentType < ApplicationRecord
  belongs_to :workspace

  has_many :content_type_fields

  def fields
    @fields ||= content_type_fields
  end

  def fields=(fields)
    fields.map! do |field|
      ContentTypeField.new(field)
      "#{field.type.titleize}Field".constantize.new(field)
      # One of the above... or... you could try to constantize at
      # the initialization on the ContentTypeField class.. which
      # would be a better place for the code.
    end
    content_type_fields << fields
    @fields = content_type_fields
  end
end
