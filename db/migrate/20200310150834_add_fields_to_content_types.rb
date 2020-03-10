class AddFieldsToContentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :content_types, :fields, :jsonb
  end
end
