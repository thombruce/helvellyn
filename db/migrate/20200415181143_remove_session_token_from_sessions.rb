class RemoveSessionTokenFromSessions < ActiveRecord::Migration[6.0]
  def change
    remove_column :sessions, :session_token
  end
end
