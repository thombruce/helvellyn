class Workspace < ApplicationRecord
  extend FriendlyId

  belongs_to :user

  friendly_id :title, use: :slugged

  has_many :content_types, dependent: :destroy

  validates_presence_of :slug
  validates_uniqueness_of :slug, message: 'is already taken'
  validates_format_of :slug, with: /\A(?:[a-z0-9][_-]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers, dashes and underscores (e.g. my_slug-1)'
  validates_format_of :slug, without: /\A\d+\Z/, message: 'cannot contain only numbers'
  # TODO: Slug validation to avoid method/attribute/path conflicts - reserved words
end
