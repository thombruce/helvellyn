class Admin::EntitiesController < AdminController
  include EntitiesSorter

  before_action :set_workspace
  before_action :set_template
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/templates/:template_id/entities.json
  # GET /:workspace_id/:template_id.json
  def index
    @entities = policy_scope(@template.entities)
      .order(entities_order(@template.default_admin_order))
      .page(params[:page])
      .per(params[:per])
    authorize Entity
  end

  # GET /workspaces/:workspace_id/templates/:template_id/entities/:id.json
  # GET /:workspace_id/:template_id/:id.json
  def show
  end

  # GET /workspaces/:workspace_id/templates/:template_id/entities/new.json
  def new
    @entity = @template.entities.build
    authorize @entity
  end

  # GET /workspaces/:workspace_id/templates/:template_id/entities/:id/edit.json
  def edit
  end

  # POST /workspaces/:workspace_id/templates/:template_id/entities.json
  def create
    @entity = @template.entities.build
    @entity.assign_attributes(entity_params)
    authorize @entity

    if @entity.save
      current_user.add_role :author, @entity
      render :show, status: :created, location: [@workspace, @template, @entity]
    else
      render json: @entity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workspaces/:workspace_id/templates/:template_id/entities/:id.json
  def update

    if @entity.update(entity_params)
      render :show, status: :ok, location: [@workspace, @template, @entity]
    else
      render json: @entity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:workspace_id/templates/:template_id/entities/:id.json
  def destroy
    @entity.destroy
    format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
      # Set workspace as an ephemeral property on the current_session for
      # authorisation of resources.
      current_session.current_workspace = @workspace
    end

    def set_template
      @template = @workspace.templates.friendly.find(params[:template_id])
    end

    def set_entity
      @entity = @template.entities.friendly.find(params[:id])
      authorize @entity
    end

    # Only allow a list of trusted parameters through.
    def entity_params
      template = @template.slug.to_sym
      fields = @template.dynamic_attributes
      params.require(template).permit(*fields, :slug, :published, :publish)
    end
end
