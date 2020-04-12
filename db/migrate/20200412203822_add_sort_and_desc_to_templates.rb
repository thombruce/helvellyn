class AddSortAndDescToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :sort, :string, default: 'created_at'
    add_column :templates, :desc, :boolean, default: true
  end
end
