json.extract! content_type, :id, :workspace_id, :name, :slug, :created_at, :updated_at
json.fields content_type.sanitized_fields
# json.url content_type_url(content_type, format: :json)
