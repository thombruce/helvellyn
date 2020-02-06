Rails.application.config.middleware.use Warden::Manager do |config|
  config.failure_app = ->(env) { SessionsController.action(:new).call(env) }

  config.default_scope = :session

  config.scope_defaults :session, strategies: [:password]
end

Warden::Manager.serialize_into_session do |session|
  session.session_token
end

Warden::Manager.serialize_from_session do |session_token|
  Session.find_by(session_token: session_token)
end

Warden::Strategies.add(:password) do
  def valid?
    params['email'] || params['password']
  end

  def authenticate!
    session = Session.authenticate(params['email'], params['password'])
    session.nil? ? fail!("Could not log in") : success!(u)
  end
end
