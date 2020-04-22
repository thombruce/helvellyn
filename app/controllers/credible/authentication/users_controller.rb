require_dependency Credible::Engine.config.root.join('app', 'controllers', 'credible', 'authentication', 'users_controller.rb').to_s

class Credible::Authentication::UsersController
  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
