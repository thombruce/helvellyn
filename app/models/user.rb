class User < ApplicationRecord
  has_secure_password

  has_many :sessions
  has_many :posts

  validates :name, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.find_by_login(login)
    find_by(email: login)
  end

  def self.authenticate(params)
    user = find_by_login(params[:login])
    user&.authenticate(params[:password])
  end
end
