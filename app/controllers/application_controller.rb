class ApplicationController < Credible::ApplicationController
  include Pundit
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :user_not_authorized

  before_action :render_application, if: proc { request.format.html? }

  def pundit_user
    current_session
  end

  def render_application
    render 'application/index'
  end

  private

  def user_not_authorized
    render json: {}.to_json, status: :forbidden
  end
end
