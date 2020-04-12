json.extract! template, :id, :workspace_id, :name, :plural, :slug, :fields, :publishable, :created_at, :updated_at

json.sort template.admin_sort
json.desc template.admin_desc

json.entities_count template.entities.size

json.url workspace_template_url(template.workspace, template, format: :json)
