class ApplicationMailer < ActionMailer::Base
  before_action { params[:app_name] = Settings.instance.name }

  default from: -> { Settings.instance.email || 'helvellyn@thombruce.com' }

  layout 'mailer'

  private

  def default_url_options
    { host: Settings.instance.hostname }
  end
end
