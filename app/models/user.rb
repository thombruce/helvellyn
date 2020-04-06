class User < ApplicationRecord
  has_secure_password
  rolify

  has_many :sessions, dependent: :destroy

  has_many :workspaces, dependent: :destroy, inverse_of: 'created_by'

  validates :name, presence: true

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.find_by_login(login)
    find_by(email: login)
  end

  def self.authenticate(params)
    user = find_by_login(params[:login])
    user&.authenticate(params[:password])
  end
end
