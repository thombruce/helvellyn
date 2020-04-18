class User < ApplicationRecord
  # See: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  # For invitations, we would prefer to allow the password to go blank until confirmed...
  # For this, perhaps, a confirmation_token serves dual purpose?
  # We would have to remove the default presence validation, re-add those we do want,
  # and ensure that our new presence validation allows blank while confirmation_token
  # is present / the user is unconfirmed.
  has_secure_password validations: false
  rolify

  has_secure_token :confirmation_token

  before_create :confirm, if: Proc.new { !Settings.mailer_configured? }

  after_create :make_admin, if: Proc.new { User.count == 1 }

  has_many :sessions, dependent: :destroy

  has_many :created_workspaces, class_name: 'Workspace', inverse_of: :created_by
  has_many :workspaces, through: :roles, class_name: 'Workspace', source: :resource, source_type: 'Workspace'

  has_many :entities, class_name: 'Entity', inverse_of: :created_by

  validates :name, presence: true, on: :update # on: :update allows us to invite users by email without having to set their name

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Custom password validation
  validate do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present? || record.confirmation_token.present?
  end

  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
  validates_confirmation_of :password, allow_blank: true
  # End custom password validation

  def self.find_by_login(login)
    find_by(email: login)
  end

  def self.authenticate(params)
    user = find_by_login(params[:login])
    user&.authenticate(params[:password])
  end

  def admin
    has_role?(:admin)
  end

  def confirm
    self.confirmation_token = nil
    self.password = SecureRandom.hex(8) unless password_digest.present?
    self.confirmed_at = Time.now.utc
  end

  def confirmed?
    confirmed_at.present?
  end

  def reset_password
    self.password_digest = nil
    self.confirmed_at = nil
    regenerate_confirmation_token
  end

  private

  def make_admin
    add_role(:admin)
  end
end
