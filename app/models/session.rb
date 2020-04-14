class Session < ApplicationRecord
  attr_accessor :login

  before_validation :generate_session_token, on: :create

  belongs_to :user

  validates :session_token, presence: true, uniqueness: true

  def self.authenticate(params)
    user = User.authenticate(params)
    new(user: user)
  end

  def jwt
    payload = {
      data: jwt_data,
      iss: 'Helvellyn'
    }
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256' # [1]
  end

  private

  def generate_session_token
    begin
      self.session_token = SecureRandom.hex
    end while self.class.exists?(session_token: session_token)
  end

  def jwt_data
    {
      session_id: id,
      user_id: user.id,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        admin: user.admin
      }
    }
  end
end

# [1] Use of `secrets` instead of `credentials` makes for a container-ready deploy on Heroku (easier setup for open source)
