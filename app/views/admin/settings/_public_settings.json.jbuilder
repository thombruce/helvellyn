json.extract! settings, :name

json.mailer_configured settings.mailer_configured

json.url public_settings_url(format: :json)
