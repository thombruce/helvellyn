class AddSortAndDescToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :api_sort, :string, default: 'created_at'
    add_column :templates, :api_desc, :boolean, default: true
    add_column :templates, :admin_sort, :string, default: 'created_at'
    add_column :templates, :admin_desc, :boolean, default: true
  end
end
