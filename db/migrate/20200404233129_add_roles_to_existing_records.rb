class AddRolesToExistingRecords < ActiveRecord::Migration[6.0]
  def up
    Workspace.find_each do |workspace|
      workspace.user.add_role :admin, workspace
    end

    ContentEntry.find_each do |content_entry|
      content_entry.content_type.workspace.user.add_role :author, content_entry
    end
  end

  def down
  end
end
