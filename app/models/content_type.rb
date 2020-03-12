class ContentType < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :name, use: [:slugged, :scoped], scope: :workspace

  has_many :content_entries, dependent: :destroy

  serialize :fields, FieldsSerializer

  before_validation do
    self.fields = fields&.map { |field| field[:slug] ? field : field.merge({ slug: field[:name].parameterize }) }
  end

  def dynamic_attributes
    fields&.map { |field| field[:slug] }
  end
end
