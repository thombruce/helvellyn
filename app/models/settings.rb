class Settings < ApplicationRecord
  validates :name, presence: true

  def self.instance(*args)
    first_or_create!(args)
  end

  def mailer_configured
    !Rails.env.production? || Rails.application.config.action_mailer.smtp_settings[:user_name].present?
  end
end
