class Admin::WorkspacesController < AdminController
  before_action :set_workspace, only: [:show, :edit, :update, :token, :destroy]

  # GET /workspaces.json
  def index
    @workspaces = policy_scope(current_user.workspaces)
    authorize Workspace
  end

  # GET /workspaces/:id.json
  # GET /:id.json
  def show
  end

  # GET /workspaces/new.json
  def new
    @workspace = Workspace.new(created_by: current_user)
    authorize @workspace
  end

  # GET /workspaces/:id/edit.json
  def edit
  end

  # POST /workspaces.json
  def create
    @workspace = Workspace.new(permitted_attributes(Workspace).merge(created_by: current_user))
    authorize @workspace

    if @workspace.save
      current_user.add_role :admin, @workspace
      render :show, status: :created, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workspaces/:id.json
  def update
    if @workspace.update(permitted_attributes(@workspace))
      render :show, status: :ok, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  def token
    if @workspace.session.regenerate_token
      render :show, status: :ok, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:id.json
  def destroy
    @workspace.destroy
    head :no_content
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
