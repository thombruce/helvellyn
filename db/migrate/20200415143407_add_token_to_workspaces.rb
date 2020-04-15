class AddTokenToWorkspaces < ActiveRecord::Migration[6.0]
  def change
    add_column :workspaces, :token, :string
    add_index :workspaces, :token, unique: true
  end
end
