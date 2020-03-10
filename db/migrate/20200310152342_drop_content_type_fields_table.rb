class DropContentTypeFieldsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :content_type_fields
  end
end
