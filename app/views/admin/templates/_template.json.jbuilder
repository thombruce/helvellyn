json.extract! template, :id, :workspace_id, :name, :plural, :slug, :fields, :publishable, :sluggable_field, :sort, :desc, :created_at, :updated_at

json.entities_count template.entities.size

json.url workspace_template_url(template.workspace, template, format: :json)
