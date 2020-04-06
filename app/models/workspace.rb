class Workspace < ApplicationRecord
  extend FriendlyId

  resourcify

  belongs_to :user
  # TODO: Change to created_by to avoid confusion with roles/members
  #       Alternatively... Remove the belonging altogether.
  #       Now that we have roles, these should suffice to show... maybe
  #       Maybe they suffice to show who possesses which Workspaces.
  #       The same is true of content_types, which currently only have
  #       an :author role assignment. BUT... if the user leaves, they
  #       take their author attribution with them. That's... another
  #       problem entirely.
  #       Anyway, MAYBE created_by is useful for denoting "personal workspaces".
  #       That is: These are YOUR workspaces vs. those you happen to be :admin of.
  #       Yeah, let's keep created_by. And give extra thought to that content_type
  #       attribution issue. Hmm... maybe an optional Author type field that stores
  #       key info... indefinitely. Perhaps.

  has_many :users, through: :roles, class_name: 'User', source: :users

  friendly_id :title, use: :slugged

  has_many :content_types, dependent: :destroy

  validates_presence_of :title

  validates_presence_of :slug
  validates_uniqueness_of :slug, message: 'is already taken'
  validates_format_of :slug, with: /\A(?:[a-z0-9][._-]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers, dashes and underscores (e.g. my_slug-1)'
  validates_format_of :slug, without: /\A\d+\Z/, message: 'cannot contain only numbers'
end
