class AddNullConstraintForUserOnEntities < ActiveRecord::Migration[6.0]
  def change
    change_column_null :entities, :user_id, false
  end
end
