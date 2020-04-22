class ApiController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  def policy_scope(scope)
    super([:api, scope])
  end

  def authorize(record, query = nil)
    super([:api, record], query)
  end

  def permitted_attributes(record, action = action_name)
    super([:api, record], action)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
      # Set workspace as an ephemeral property on the current_session for
      # authorisation of resources.
      current_session.current_workspace = @workspace
    end
end
