class AddSessionTokenToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :session_token, :string
    add_index :sessions, :session_token, unique: true
  end
end
