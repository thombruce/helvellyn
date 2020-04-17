class AddUserToEntities < ActiveRecord::Migration[6.0]
  def change
    add_reference :entities, :user, foreign_key: true
  end
end
