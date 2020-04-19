class ApplicationMailer < ActionMailer::Base
  default from: Settings.instance.email || 'helvellyn@thombruce.com'
  layout 'mailer'

  private

  def default_url_options
    { host: Settings.instance.hostname }
  end
end
