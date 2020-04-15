class AddWorkspaceToSessions < ActiveRecord::Migration[6.0]
  def change
    add_reference :sessions, :workspace, foreign_key: true
  end
end
