class ConfirmationMailer < ApplicationMailer
  def confirmation_email
    @settings = Settings.instance
    @user = params[:user]
    @url  = root_url(host: @settings.hostname)
    mail(to: @user.email, subject: "Welcome to #{@settings.name}")
  end
end
