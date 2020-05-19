class Admin::UploadsController < AdminController
  before_action :set_workspace
  before_action :set_upload, only: [:show, :destroy]

  def index
    @uploads = policy_scope(@workspace.uploads)
    authorize Upload
  end

  def show
  end

  def new
    @upload = @workspace.uploads.build
    authorize @upload
  end

  def create
    @upload = @workspace.uploads.build
    authorize @upload

    @upload.assign_attributes(permitted_attributes(Upload))

    if @upload.save
      render :show, status: :created, location: [@workspace, @upload]
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @upload.destroy
    format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = @workspace.uploads.find(params[:id])
      authorize @upload
    end
end
