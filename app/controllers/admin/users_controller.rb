class Admin::UsersController < AdminController
  before_action :set_workspace
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/users.json
  def index
    @users = policy_scope(@workspace.users)
    authorize User
  end

  # GET /workspaces/:workspace_id/users/:id.json
  def show
  end

  # POST /workspaces/:workspace_id/users/invite.json
  def invite
    @user = User.find_by(email: permitted_attributes(User)[:email])
    authorize @user

    if @user.add_role(permitted_attributes(User)[:role], @workspace)
      render :show, status: :created, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = @workspace.users.find(params[:id])
      authorize @user
    end
end
