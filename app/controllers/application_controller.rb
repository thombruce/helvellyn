class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  helper_method :current_user
  helper_method :current_session

  def pundit_user
    current_session
  end

  def current_user
    current_session.user
  end
  
  def current_session
    warden.user(:session) || Session.new(user: nil)
  end
  
  def warden
    request.env['warden']
  end
end
