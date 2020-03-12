json.extract! session, :id, :session_token, :created_at, :updated_at
json.jwt session.jwt
# json.url session_url(session, format: :json)
