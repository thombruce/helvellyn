class Api::EntitiesController < ApiController
  include EntitiesSorter

  before_action :set_workspace
  before_action :set_template
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/templates/:template_id/entities.json
  # GET /:workspace_id/:template_id.json
  def index
    @entities = policy_scope(@template.entities)
      .order(entities_order(@template.default_api_order))
      .page(params[:page])
      .per(params[:per])
    authorize Entity
  end

  # GET /workspaces/:workspace_id/templates/:template_id/entities/:id.json
  # GET /:workspace_id/:template_id/:id.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = @workspace.templates.friendly.find(params[:template_id])
    end

    def set_entity
      @entity = @template.entities.friendly.find(params[:id])
      authorize @entity
    end
end
