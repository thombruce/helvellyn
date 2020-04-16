class ApplicationMailer < ActionMailer::Base
  default from: Settings.instance.email
  layout 'mailer'
end
