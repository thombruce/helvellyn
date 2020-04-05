class Authentication::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate!, only: [:new, :create]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    authorize [:authentication, @user]
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(permitted_attributes(User))
    authorize [:authentication, @user]

    if @user.save
      @session = Session.create(user: @user)
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(permitted_attributes(@user))
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
      authorize [:authentication, @user]
    end  
end
