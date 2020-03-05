class RenameBlogIdToWorkspaceIdOnPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column      :posts, :blog_id, :workspace_id
  end
end
