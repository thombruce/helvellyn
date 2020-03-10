class ContentType < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :name, use: :scoped, scope: :workspace

  has_many :content_type_fields

  def fields
    @fields ||= content_type_fields
  end

  def fields=(fields)
    fields.map! do |field_params|
      type = field_params.delete(:type)
      "#{type.titleize}Field".constantize.find_or_initialize_by(field_params) # TODO: Too many queries. Just pull 'em all in and compare.
      # TODO: This needs to be scoped to a ContentType instance too.
    end
    content_type_fields << fields
    @fields = content_type_fields
  end
end
