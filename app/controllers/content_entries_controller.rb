class ContentEntriesController < ApplicationController
  before_action :set_workspace
  before_action :set_content_type
  before_action :set_content_entry, only: [:show, :edit, :update, :destroy]

  # GET /workspaces/:workspace_id/content_types/:content_type_id/content_entries.json
  # GET /:workspace_id/:content_type_id.json
  def index
    @content_entries = policy_scope(ContentEntry.all)
  end

  # GET /workspaces/:workspace_id/content_types/:content_type_id/content_entries/:id.json
  # GET /:workspace_id/:content_type_id/:id.json
  def show
  end

  # GET /workspaces/:workspace_id/content_types/:content_type_id/content_entries/new.json
  def new
    @content_entry = @content_type.content_entries.build
    authorize @content_entry
  end

  # GET /workspaces/:workspace_id/content_types/:content_type_id/content_entries/:id/edit.json
  def edit
  end

  # POST /workspaces/:workspace_id/content_types/:content_type_id/content_entries.json
  def create
    @content_entry = @content_type.content_entries.build
    @content_entry.assign_attributes(content_entry_params)
    authorize @content_entry

    if @content_entry.save
      render :show, status: :created, location: [@workspace, @content_type, @content_entry]
    else
      render json: @content_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workspaces/:workspace_id/content_types/:content_type_id/content_entries/:id.json
  def update

    if @content_entry.update(content_entry_params)
      render :show, status: :ok, location: [@workspace, @content_type, @content_entry]
    else
      render json: @content_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/:workspace_id/content_types/:content_type_id/content_entries/:id.json
  def destroy
    @content_entry.destroy
    format.json { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:workspace_id])
    end

    def set_content_type
      @content_type = @workspace.content_types.friendly.find(params[:content_type_id])
    end

    def set_content_entry
      @content_entry = @content_type.content_entries.friendly.find(params[:id])
      authorize @content_entry
    end

    # Only allow a list of trusted parameters through.
    def content_entry_params
      content_type = @content_type.slug.to_sym
      fields = @content_type.dynamic_attributes
      params.require(content_type).permit(*fields, :published, :publish)
    end
end
