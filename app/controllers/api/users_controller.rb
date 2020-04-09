class Api::UsersController < ApiController
  before_action :set_workspace
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/users.json
  def index
    @users = policy_scope(@workspace.users)
  end

  # GET /workspaces/:workspace_id/users/:id.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
    end

    def set_user
      @user = @workspace.users.find(params[:id])
      authorize @user
    end
end