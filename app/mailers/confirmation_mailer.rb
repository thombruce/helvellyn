class ConfirmationMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email, subject: 'Welcome to Helvellyn') # TODO: This should reflect the app name
  end
end
