class User < ApplicationRecord
  has_secure_password
  rolify

  after_create :make_admin, if: Proc.new { User.count == 1 }

  has_many :sessions, dependent: :destroy

  has_many :workspaces, through: :roles, class_name: 'Workspace', source: :resource, source_type: 'Workspace'

  validates :name, presence: true, on: :update # on: :update allows us to invite users by email without having to set their name

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

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

  private

  def make_admin
    add_role(:admin)
  end
end
