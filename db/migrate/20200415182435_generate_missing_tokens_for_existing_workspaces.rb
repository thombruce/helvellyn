class GenerateMissingTokensForExistingWorkspaces < ActiveRecord::Migration[6.0]
  def up
    Workspace.find_each do |workspace|
      workspace.create_session
    end
  end

  def down
  end
end
