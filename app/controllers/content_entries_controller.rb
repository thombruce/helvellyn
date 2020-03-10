class ContentEntriesController < ApplicationController
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
    @content_entry = ContentEntry.new
    authorize @content_entry
  end

  # GET /content_entries/1/edit
  def edit
  end

  # POST /content_entries
  # POST /content_entries.json
  def create
    @content_entry = ContentEntry.new(content_entry_params)
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
    def set_content_entry
      @content_entry = ContentEntry.find(params[:id])
      authorize @content_entry
    end

    # Only allow a list of trusted parameters through.
    def content_entry_params
      params.require(:content_entry).permit(:workspace_id, :content_type_id)
    end
end
