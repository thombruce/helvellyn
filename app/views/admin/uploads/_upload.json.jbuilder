json.extract! upload, :id, :workspace_id, :created_at, :updated_at

if upload.file.attached?
  json.file rails_blob_url(upload.file)
end

# TODO: URL ?
