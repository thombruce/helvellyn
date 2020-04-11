class Template < ApplicationRecord
  extend FriendlyId

  belongs_to :workspace

  friendly_id :slug_candidates, use: [:slugged, :scoped], scope: :workspace

  has_many :entities, dependent: :destroy

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

  validates :fields, presence: true, fields: { reserved: Entity.new.methods }

  validate :sluggable_field_is_a_string

  def slug_candidates
    [:plural, :name]
  end

  def schema
    schema = fields.map { |field| [field[:slug], { name: field[:name], type: field[:type] }] }.flatten
    HashWithIndifferentAccess[*schema]
  end

  def dynamic_attributes
    schema.keys
  end

  # TODO: Creates a Hash schema like:
  # {
  #   title: { name: 'Title', type: 'String', required: false },
  #   content: { name: 'Content', type: 'Rich Text', format: "/some_regex or enumerable/" },
  #   url: { name: 'URL', type: 'String', length: { min: 3, max: 50 } }
  # }
  # Let us ignore complex validations for now. Required is essential.

  private

  def sluggable_field_is_a_string
    record.errors[:base] << "Only a string field may be used as a slug" if fields.find { |field| field[:slug] == sluggable_field && field[:type] != 'String' }
  end
end
