class Api::WorkspacesController < ApiController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:id.json
  # GET /:id.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:id])
      # Set workspace as an ephemeral property on the current_session for
      # authorisation of resources.
      current_session.current_workspace = @workspace
      authorize @workspace
    end
end
