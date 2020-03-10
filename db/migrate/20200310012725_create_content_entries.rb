class CreateContentEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :content_entries do |t|
      t.references :workspace, null: false, foreign_key: true
      t.references :content_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
