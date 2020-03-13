class AddPluralToContentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :content_types, :plural, :string
  end
end
