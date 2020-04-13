json.extract! template, :id, :workspace_id, :name, :plural, :slug, :fields, :publishable, :created_at, :updated_at

json.sort template.api_sort
json.desc template.api_desc

json.entities_count template.entities.size

json.url workspace_template_url(template.workspace, template, format: :json)

# TODO: This and other Template views are now public via the :template_id/template route...
#       They may contain confidential information, particularly if the content type is not
#       publishable. Reconsider what data we emit above, and consider...
#       - DO NOT permit Template to be shown that does not represent publishable type.
#       - DO NOT list Templates in index that do not represent publishable type.
