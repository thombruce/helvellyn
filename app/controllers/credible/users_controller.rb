class Credible::UsersController < ApplicationController
  include Credible::Controllers::UsersController

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end