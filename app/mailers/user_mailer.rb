class UserMailer < ApplicationMailer
  def confirmation_email
    @settings = Settings.instance
    @user = params[:user]
    @url  = root_url(host: @settings.hostname)
    @confirmation_url = @url + 'confirm/' + @user.confirmation_token
    mail(from: @settings.email, to: @user.email, subject: "Welcome to #{@settings.name} | Please confirm your account")
  end

  def invitation_email
    @settings = Settings.instance
    @user = params[:user]
    @url  = root_url(host: @settings.hostname)
    mail(from: @settings.email, to: @user.email, subject: "You have been invited to #{@settings.name}")
  end
end
