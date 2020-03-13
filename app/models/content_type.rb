class ContentType < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :name, use: [:slugged, :scoped], scope: :workspace

  has_many :content_entries, dependent: :destroy

  serialize :fields, FieldsSerializer

  before_validation do
    self.fields = fields&.map { |field| field[:slug] ? field : field.merge({ slug: field[:name].parameterize }) }
  end

  validate :sluggable_fields_do_not_exceed_one
  validate :sluggable_field_must_be_a_string

  def dynamic_attributes
    fields&.map { |field| field[:slug] }
  end

  private

  def sluggable_fields_do_not_exceed_one
    if fields.select { |field| field[:sluggable] }.count > 1
      errors[:base] << "Only one field may be used as a slug"
    end
  end

  def sluggable_field_must_be_a_string
    if fields.select { |field| field[:sluggable] && field[:type] != 'String' }.any?
      errors[:base] << "Only a string field may be used as a slug"
    end
  end
end
