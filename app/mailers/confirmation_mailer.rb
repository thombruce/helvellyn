class ConfirmationMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def confirmation_email
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email, subject: 'Welcome to Helvellyn') # TODO: This should reflect the app name
  end
end
