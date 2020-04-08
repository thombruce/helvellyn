json.extract! content_entry, :id, :content_type_id, :slug, :created_at, :updated_at, :published_at, :generated_fields

json.published content_entry.published

content_entry.data.each do |key, value|
  json.set! key, value
end

json.url pretty_workspace_content_type_content_entry_url(@workspace, @content_type, content_entry, format: :json)
