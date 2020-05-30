class User < ApplicationRecord
  include Credible::User

  # See: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  # For invitations, we would prefer to allow the password to go blank until confirmed...
  # For this, perhaps, a confirmation_token serves dual purpose?
  # We would have to remove the default presence validation, re-add those we do want,
  # and ensure that our new presence validation allows blank while confirmation_token
  # is present / the user is unconfirmed.
  rolify

  before_create :confirm_without_email, if: Proc.new { !Settings.mailer_configured? }

  after_create :make_admin, if: Proc.new { User.count == 1 }

  has_many :created_workspaces, class_name: 'Workspace', inverse_of: :created_by
  has_many :workspaces, through: :roles, class_name: 'Workspace', source: :resource, source_type: 'Workspace'

  has_many :entities, class_name: 'Entity', inverse_of: :created_by

  validates_presence_of :username
  validates_uniqueness_of :username, message: 'is already taken'
  validates_format_of :username, with: /\A(?:[a-z0-9][_]?)*[a-z0-9]\z/i, message: 'must only contain letters, numbers and underscores (e.g. my_username)'
  validates_format_of :username, without: /\A\d+\Z/, message: 'cannot contain only numbers'

  # validates :name, presence: true, on: :update # on: :update allows us to invite users by email without having to set their name
  # TODO: No, it doesn't. Add a conditional to this validation based on confirmation.

  def admin
    has_role?(:admin)
  end

  private

  def make_admin
    add_role(:admin)
  end

  def confirm_without_email
    confirm(confirmation_token)
  end
end
