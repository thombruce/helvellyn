json.extract! workspace, :id, :user_id, :title, :slug, :created_at, :updated_at

json.url workspace_url(workspace, format: :json) # TODO: Pretty route (conditionally?)
