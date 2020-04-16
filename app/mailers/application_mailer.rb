class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com' # TODO: Settings constant is not working here... maybe rename.
  layout 'mailer'
end
