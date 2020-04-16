class AddEmailToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :email, :string, default: 'from@example.com'
  end
end
