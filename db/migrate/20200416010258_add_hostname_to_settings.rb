class AddHostnameToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :hostname, :string
  end
end
