json.extract! content_type, :id, :workspace_id, :name, :slug, :fields, :created_at, :updated_at

json.url workspace_content_type_url(@workspace, content_type, format: :json)
