json.extract! workspace, :id, :user_id, :title, :slug, :created_at, :updated_at

if current_user.has_role?(:admin, workspace)
  json.token workspace.token
end

json.templates do
  json.array! workspace.templates, partial: "admin/templates/template", as: :template
end

json.user_roles Workspace.find_roles(:any, current_user).where(resource_id: workspace.id).map(&:name)

json.url pretty_workspace_url(workspace, format: :json)
