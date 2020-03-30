class AddGeneratedFieldsToContentEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :content_entries, :generated_fields, :jsonb
  end
end
