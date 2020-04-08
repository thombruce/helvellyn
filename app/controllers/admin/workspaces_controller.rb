class Admin::WorkspacesController < AdminController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  # GET /workspaces.json
  def index
    @workspaces = policy_scope(current_user.workspaces)
  end

  # GET /workspaces/:id.json
  # GET /:id.json
  def show
  end

  # GET /workspaces/new.json
  def new
    @workspace = current_user.workspaces.new
    authorize @workspace
  end

  # GET /workspaces/:id/edit.json
  def edit
  end

  # POST /workspaces.json
  def create
    @workspace = current_user.workspaces.build(permitted_attributes(Workspace))
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

  # DELETE /workspaces/:id.json
  def destroy
    @workspace.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:id])
      authorize @workspace
    end
end
