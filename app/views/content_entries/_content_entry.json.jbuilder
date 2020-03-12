json.extract! content_entry, :id, :content_type_id, :created_at, :updated_at, :published_at

json.published content_entry.published

content_entry.data.each do |key, value|
  json.set! key, value
end

json.url workspace_content_type_content_entry_url(@workspace, @content_type, content_entry, format: :json) # TODO: Pretty route (conditionally?)
