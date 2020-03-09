json.partial! "content_types/content_type", content_type: @content_type

json.fields do
  json.array! @content_type.fields, partial: "content_type_fields/content_type_field", as: :content_type_field
end
