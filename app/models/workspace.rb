class Workspace < ApplicationRecord
  extend FriendlyId

  resourcify

  belongs_to :created_by, class_name: 'User', foreign_key: 'user_id'

  has_many :users, through: :roles, class_name: 'User', source: :users

  friendly_id :title, use: :slugged

  has_many :templates, dependent: :destroy

  validates_presence_of :title

  validates_presence_of :slug
  validates_uniqueness_of :slug, message: 'is already taken'
  validates_format_of :slug, with: /\A(?:[a-z0-9][._-]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers, dashes and underscores (e.g. my_slug-1)'
  validates_format_of :slug, without: /\A\d+\Z/, message: 'cannot contain only numbers'
end
