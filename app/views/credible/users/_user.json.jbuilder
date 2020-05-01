json.extract! user, :id, :name, :email, :created_at, :updated_at

json.access_token @session.access_token if @session

json.url user_url(user, format: :json)
