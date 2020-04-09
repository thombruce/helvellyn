class RenameContentEntriesToEntities < ActiveRecord::Migration[6.0]
  def change
    rename_table :content_entries, :entities
  end
end
