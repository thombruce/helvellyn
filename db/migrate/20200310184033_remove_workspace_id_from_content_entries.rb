class RemoveWorkspaceIdFromContentEntries < ActiveRecord::Migration[6.0]
  def change
    remove_column :content_entries, :workspace_id
  end
end
