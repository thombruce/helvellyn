class CreateContentTypeFields < ActiveRecord::Migration[6.0]
  def change
    create_table :content_type_fields do |t|
      t.references :content_type, null: false, foreign_key: true
      t.string :name
      t.integer :actable_id
      t.string :actable_type

      t.timestamps
    end
  end
end
