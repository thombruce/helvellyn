class User < ApplicationRecord
  include Credible::User

  extend FriendlyId

  # See: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  # For invitations, we would prefer to allow the password to go blank until confirmed...
  # For this, perhaps, a confirmation_token serves dual purpose?
  # We would have to remove the default presence validation, re-add those we do want,
  # and ensure that our new presence validation allows blank while confirmation_token
  # is present / the user is unconfirmed.
  rolify

  friendly_id :generate_username, use: :slugged, slug_column: :username

  def should_generate_new_friendly_id?
    username.blank?
    # TODO: We should not generate this on signUp or account edit.
    #       The user should be forced to set a username.
    #       This is used for invite.
  end

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

  def generate_username
    # SecureRandom.hex(4) # 8 characters, 4.3 billion variations
    SecureRandom.hex(5) # 10 characters, 1 trillion variations

    # TODO: Maybe add a loop to check against DB and ensure uniqueness.
  end

  def make_admin
    add_role(:admin)
  end

  def confirm_without_email
    confirm(confirmation_token)
  end
end
