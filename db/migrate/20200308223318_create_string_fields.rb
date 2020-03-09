class CreateStringFields < ActiveRecord::Migration[6.0]
  def change
    create_table :string_fields do |t|
      t.integer :min_length
      t.integer :max_length
      t.string :default_value

      t.timestamps
    end
  end
end
