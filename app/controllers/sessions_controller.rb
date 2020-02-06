class SessionsController < ApplicationController
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
        warden.set_user(@session)
        format.html { redirect_to @session.user, notice: 'Session was successfully created.' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @session = current_session
    authorize @session
    warden.logout
    @session.destroy
    redirect_to new_session_path
  end
end
