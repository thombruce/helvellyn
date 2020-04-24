json.extract! user, :id, :name, :email, :created_at, :updated_at

json.admin user.admin

json.role user.roles.find_by(resource_type: 'Workspace', resource_id: @workspace.id).name if @workspace

json.permissions user_permissions(user)

json.url workspace_user_url(@workspace, user, format: :json)
