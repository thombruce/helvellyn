class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :singleton_guard, default: 0
      t.string :name, default: 'Helvellyn'

      t.timestamps
    end
    add_index :settings, :singleton_guard, unique: true
  end
end


