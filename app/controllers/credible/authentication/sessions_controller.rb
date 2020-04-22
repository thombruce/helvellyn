require_dependency Credible::Engine.config.root.join('app', 'controllers', 'credible', 'authentication', 'sessions_controller.rb').to_s

class Credible::Authentication::SessionsController
  private
    def session_params
      params.require(:session).permit(:login, :password)
    end
end
