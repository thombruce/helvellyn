class RenameContentTypeIdToTemplateIdOnEntities < ActiveRecord::Migration[6.0]
  def change
    rename_column :entities, :content_type_id, :template_id
  end
end
