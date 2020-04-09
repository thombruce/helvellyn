class Admin::TemplatesController < AdminController
  before_action :set_workspace
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/templates.json
  def index
    @templates = policy_scope(@workspace.templates)
  end

  # GET /workspaces/:workspace_id/templates/:id.json
  def show
  end

  # GET /workspaces/:workspace_id/templates/new.json
  def new
    @template = @workspace.templates.build
    authorize @template
  end

  # GET /workspaces/:workspace_id/templates/:id/edit.json
  def edit
  end

  # POST /workspaces/:workspace_id/templates.json
  def create
    @template = @workspace.templates.build(permitted_attributes(Template))
    authorize @template

    if @template.save
      render :show, status: :created, location: [@workspace, @template]
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workspaces/:workspace_id/templates/:id.json
  def update
    if @template.update(permitted_attributes(@template))
      render :show, status: :ok, location: [@workspace, @template]
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:workspace_id/templates/:id.json
  def destroy
    @template.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
    end

    def set_template
      @template = @workspace.templates.friendly.find(params[:id])
      authorize @template
    end
end
