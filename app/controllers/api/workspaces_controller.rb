class Api::WorkspacesController < ApiController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:id.json
  # GET /:id.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      super
      authorize @workspace
    end
end
