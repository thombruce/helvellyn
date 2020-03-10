json.extract! content_entry, :id, :content_type_id, :created_at, :updated_at

content_entry.data.each do |key, value|
  json.set! key, value
end

# json.url content_entry_url(content_entry, format: :json)
