json.extract! settings, :name, :created_at, :updated_at

json.url settings_url(@settings, format: :json)
