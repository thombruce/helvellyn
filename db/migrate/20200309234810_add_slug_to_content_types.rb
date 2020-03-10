class AddSlugToContentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :content_types, :slug, :string
    add_index :content_types, [:workspace_id, :slug], unique: true
  end
end
