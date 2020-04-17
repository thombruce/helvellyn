class Settings < ApplicationRecord
  validates :name, presence: true

  def self.instance(*args)
    first_or_create!(args)
  end

  def self.mailer_configured?
    !Rails.env.production? || Rails.application.config.action_mailer.smtp_settings.try(:[], :user_name).present?
  end

  def mailer_configured
    self.class.mailer_configured?
  end
end
