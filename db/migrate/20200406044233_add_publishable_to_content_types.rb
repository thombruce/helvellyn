class AddPublishableToContentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :content_types, :publishable, :boolean, default: true
  end
end
