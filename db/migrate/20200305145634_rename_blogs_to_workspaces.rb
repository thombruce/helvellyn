class RenameBlogsToWorkspaces < ActiveRecord::Migration[6.0]
  def change
    rename_table :blogs, :workspaces
  end
end
