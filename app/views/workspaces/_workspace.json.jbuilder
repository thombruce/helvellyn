json.extract! workspace, :id, :user_id, :title, :slug, :created_at, :updated_at

json.url pretty_workspace_url(workspace, format: :json)
