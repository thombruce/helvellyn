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

  def dynamic_attributes
    fields&.map { |field| field[:slug] }
  end

  def slug_candidates
    [:plural, :name]
  end

  def schema
    # TODO: fields.each do |field|
  end
end
