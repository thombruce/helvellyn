class AddDataToContentEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :content_entries, :data, :jsonb
  end
end
