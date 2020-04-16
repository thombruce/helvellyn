json.extract! settings, :name, :hostname, :email, :created_at, :updated_at

json.mailer_configured settings.mailer_configured

json.url settings_url(format: :json)
