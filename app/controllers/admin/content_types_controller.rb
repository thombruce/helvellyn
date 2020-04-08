class Admin::ContentTypesController < AdminController
  before_action :set_workspace
  before_action :set_content_type, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/content_types.json
  def index
    @content_types = policy_scope(@workspace.content_types)
  end

  # GET /workspaces/:workspace_id/content_types/:id.json
  def show
  end

  # GET /workspaces/:workspace_id/content_types/new.json
  def new
    @content_type = @workspace.content_types.build
    authorize @content_type
  end

  # GET /workspaces/:workspace_id/content_types/:id/edit.json
  def edit
  end

  # POST /workspaces/:workspace_id/content_types.json
  def create
    @content_type = @workspace.content_types.build(permitted_attributes(ContentType))
    authorize @content_type

    if @content_type.save
      render :show, status: :created, location: [@workspace, @content_type]
    else
      render json: @content_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workspaces/:workspace_id/content_types/:id.json
  def update
    if @content_type.update(permitted_attributes(@content_type))
      render :show, status: :ok, location: [@workspace, @content_type]
    else
      render json: @content_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:workspace_id/content_types/:id.json
  def destroy
    @content_type.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
    end

    def set_content_type
      @content_type = @workspace.content_types.friendly.find(params[:id])
      authorize @content_type
    end
end
