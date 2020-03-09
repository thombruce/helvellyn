json.extract! content_type_field, :name

json.type content_type_field.specific.class.name.chomp('Field')

# json.url content_type_url(content_type, format: :json)
