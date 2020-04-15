class Api::TemplatesController < ApiController
  before_action :set_workspace
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/templates/:id.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
      current_session.current_workspace = @workspace
    end

    def set_template
      @template = @workspace.templates.friendly.find(params[:id])
      authorize @template
    end
end
