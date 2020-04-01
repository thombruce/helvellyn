json.extract! workspace, :id, :user_id, :title, :slug, :created_at, :updated_at

json.content_types do
  json.array! workspace.content_types, partial: "content_types/content_type", as: :content_type
end

json.url pretty_workspace_url(workspace, format: :json)
