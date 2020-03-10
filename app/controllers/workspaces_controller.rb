class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  # GET /workspaces
  # GET /workspaces.json
  def index
    @workspaces = policy_scope(Workspace)
  end

  # GET /workspaces/1
  # GET /workspaces/1.json
  def show
  end

  # GET /workspaces/new
  def new
    @workspace = current_user.workspaces.new
    authorize @workspace
  end

  # GET /workspaces/1/edit
  def edit
  end

  # POST /workspaces
  # POST /workspaces.json
  def create
    @workspace = current_user.workspaces.build(permitted_attributes(Workspace))
    authorize @workspace

    respond_to do |format|
      if @workspace.save
        format.html { redirect_to @workspace, notice: 'Workspace was successfully created.' }
        format.json { render :show, status: :created, location: @workspace }
      else
        format.html { render :new }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workspaces/1
  # PATCH/PUT /workspaces/1.json
  def update
    respond_to do |format|
      if @workspace.update(permitted_attributes(@workspace))
        format.html { redirect_to @workspace, notice: 'Workspace was successfully updated.' }
        format.json { render :show, status: :ok, location: @workspace }
      else
        format.html { render :edit }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspaces/1
  # DELETE /workspaces/1.json
  def destroy
    @workspace.destroy
    respond_to do |format|
      format.html { redirect_to workspaces_url, notice: 'Workspace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.friendly.find(params[:id])
      authorize @workspace
    end
end
