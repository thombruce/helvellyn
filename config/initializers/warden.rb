Rails.application.config.middleware.use Warden::Manager do |config|
  config.failure_app = ->(env) { SessionsController.action(:new).call(env) }

  config.default_scope = :session

  config.scope_defaults :session, strategies: [:jwt]
end

Warden::Strategies.add(:jwt) do
  def valid?
    env['HTTP_USER_TOKEN']
  end

  def env
    request.env
  end

  def authenticate!
    begin
      token =
        JWT.decode env['HTTP_USER_TOKEN'], Rails.application.secrets.secret_key_base, true,
                   iss: 'DashboardByThom', verify_iss: true, algorithm: 'HS256'
    rescue JWT::InvalidIssuerError
      fail!('Could not authenticate')
    end

    session = Session.find(token[0]['data']['session_id'])

    session ? success!(session) : fail!('Could not authenticate')
  end

  def store?
    false
  end
end
