class AddSlugToContentEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :content_entries, :slug, :string
    add_index :content_entries, [:content_type_id, :slug], unique: true
  end
end
