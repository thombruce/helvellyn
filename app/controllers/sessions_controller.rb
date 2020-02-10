class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :destroy]

  skip_before_action :authenticate!, only: [:new, :create]

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
    authorize @session
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.authenticate(permitted_attributes(Session))
    authorize @session

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session.user, notice: 'Session was successfully created.' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  # DELETE /sessions/current
  # DELETE /sessions/current.json
  def destroy
    warden.logout
    @session.destroy
    respond_to do |format|
      format.html { redirect_to new_session_path, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find_by(id: params[:id]) || current_session
      authorize @session
    end
end
