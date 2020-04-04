class ContentType < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :slug_candidates, use: [:slugged, :scoped], scope: :workspace

  has_many :content_entries, dependent: :destroy

  serialize :fields, FieldsSerializer

  before_validation do
    self.fields = fields&.map { |field| field[:slug] ? field : field.merge({ slug: field[:name].parameterize }) }
  end

  validates_presence_of :name
  validates_presence_of :plural

  validates_presence_of :slug
  validates_uniqueness_of :slug, scope: :workspace
  validates_format_of :slug, with: /\A(?:[a-z0-9][_-]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers, dashes and underscores (e.g. my_slug-1)'
  validates_format_of :slug, without: /\A\d+\Z/, message: 'cannot contain only numbers'

  validate :fields_do_not_conflict_with_content_entry_methods
  validate :sluggable_fields_do_not_exceed_one
  validate :sluggable_field_must_be_a_string

  # TODO: Validate presence of field name and type

  def dynamic_attributes
    fields&.map { |field| field[:slug] }
  end

  def slug_candidates
    [:plural, :name]
  end

  private

  def fields_do_not_conflict_with_content_entry_methods
    if (ContentEntry.new.methods & dynamic_attributes).any?
      errors[:base] << "Field names contain reserved words"
    end
  end

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
