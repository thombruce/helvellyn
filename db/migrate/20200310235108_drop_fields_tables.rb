class DropFieldsTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :string_fields
    drop_table :text_fields
  end
end
