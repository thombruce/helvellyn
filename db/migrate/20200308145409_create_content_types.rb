class CreateContentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :content_types do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
