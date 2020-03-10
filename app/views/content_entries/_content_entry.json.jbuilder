json.extract! content_entry, :id, :workspace_id, :content_type_id, :created_at, :updated_at
json.url content_entry_url(content_entry, format: :json)
