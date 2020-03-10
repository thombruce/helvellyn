class ContentEntriesController < ApplicationController
  before_action :set_workspace
  before_action :set_content_type
  before_action :set_content_entry, only: [:show, :edit, :update, :destroy]

  # GET /content_entries
  # GET /content_entries.json
  def index
    @content_entries = policy_scope(ContentEntry.all)
  end

  # GET /content_entries/1
  # GET /content_entries/1.json
  def show
  end

  # GET /content_entries/new
  def new
    @content_entry = @content_type.content_entries.build
    authorize @content_entry
  end

  # GET /content_entries/1/edit
  def edit
  end

  # POST /content_entries
  # POST /content_entries.json
  def create
    @content_entry = @content_type.content_entries.build(workspace: @workspace)
    @content_entry.assign_attributes(content_entry_params) # TODO: Doesn't actually need to belong to workspace...
    authorize @content_entry

    if @content_entry.save
      render :show, status: :created, location: @content_entry
    else
      render json: @content_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /content_entries/1
  # PATCH/PUT /content_entries/1.json
  def update

    if @content_entry.update(content_entry_params)
      render :show, status: :ok, location: @content_entry
    else
      render json: @content_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /content_entries/1
  # DELETE /content_entries/1.json
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
      @content_entry = ContentEntry.find(params[:id])
      authorize @content_entry
    end

    # Only allow a list of trusted parameters through.
    def content_entry_params
      content_type = @content_type.slug.to_sym
      fields = @content_type.sanitized_fields.map { |f| f[:slug].to_sym }
      params.require(content_type).permit(*fields)
    end
end
