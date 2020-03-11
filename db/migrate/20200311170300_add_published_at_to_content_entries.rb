class AddPublishedAtToContentEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :content_entries, :published_at, :datetime
  end
end
