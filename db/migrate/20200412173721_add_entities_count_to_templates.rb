class AddEntitiesCountToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :entities_count, :integer
  end
end
