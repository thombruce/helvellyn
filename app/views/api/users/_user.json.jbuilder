json.extract! user, :id, :name, :email, :created_at, :updated_at

json.role user.roles.find_by(resource_type: 'Workspace', resource_id: @workspace.id).name if @workspace

json.url user_url(user, format: :json)
