class CreateTextFields < ActiveRecord::Migration[6.0]
  def change
    create_table :text_fields do |t|
      t.boolean :wysiwyg
      t.integer :min_length
      t.integer :max_length
      t.text :default_value

      t.timestamps
    end
  end
end
