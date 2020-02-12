class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  include Pundit
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :render_application, if: proc { request.format.html? }
  before_action :authenticate!

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

  def authenticate!
    warden.authenticate!
  end

  private

  def render_application
    render 'application/index'
  end
end
