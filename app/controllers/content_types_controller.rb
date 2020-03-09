class ContentTypesController < ApplicationController
  before_action :set_content_type, only: [:show, :edit, :update, :destroy]

  # GET /content_types
  # GET /content_types.json
  def index
    @content_types = policy_scope(current_workspace.content_types)
  end

  # GET /content_types/1
  # GET /content_types/1.json
  def show
  end

  # GET /content_types/new
  def new
    @content_type = current_workspace.content_types.build
    authorize @content_type
  end

  # GET /content_types/1/edit
  def edit
  end

  # POST /content_types
  # POST /content_types.json
  def create
    @content_type = current_workspace.content_types.build(permitted_attributes(ContentType))
    authorize @content_type

    if @content_type.save
      render :show, status: :created, location: @content_type
    else
      render json: @content_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /content_types/1
  # PATCH/PUT /content_types/1.json
  def update
    if @content_type.update(permitted_attributes(@content_type))
      render :show, status: :ok, location: @content_type
    else
      render json: @content_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /content_types/1
  # DELETE /content_types/1.json
  def destroy
    @content_type.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_type
      @content_type = current_workspace.content_types.find(params[:id])
      authorize @content_type
    end
end
