Rails.application.config.middleware.use Warden::Manager do |config|
  config.failure_app = ->(env) { SessionsController.action(:new).call(env) }

  config.default_scope = :session

  config.scope_defaults :session, store: false, strategies: [:jwt, :api_token]
end

Warden::Strategies.add(:jwt) do
  def valid?
    env['HTTP_AUTHORIZATION']
  end

  def env
    request.env
  end

  def authenticate!
    begin
      pattern = /^Bearer /
      header = env['HTTP_AUTHORIZATION']
      jwt = header.gsub(pattern, '') if header && header.match(pattern)
      token =
        JWT.decode jwt, Rails.application.secrets.secret_key_base, true,
                   iss: 'Helvellyn', verify_iss: true, algorithm: 'HS256' # [1]
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

Warden::Strategies.add(:api_token) do
  def valid?
    request.env['HTTP_API_TOKEN']
  end

  def env
    request.env
  end

  def authenticate!
    session = Session.find_by(token: env['HTTP_API_TOKEN'])
    session ? success!(session) : fail!('Could not authenticate')
  end

  def store?
    false
  end
end

# [1] Use of `secrets` instead of `credentials` makes for a container-ready deploy on Heroku (easier setup for open source)
