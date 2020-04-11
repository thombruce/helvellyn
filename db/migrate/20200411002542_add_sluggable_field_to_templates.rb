class AddSluggableFieldToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :sluggable_field, :string
  end
end
