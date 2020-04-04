class UpdateContentEntriesForRichText < ActiveRecord::Migration[6.0]
  def up
    ContentEntry.find_each do |content_entry|
      content_entry.data[:content] = content_entry.generated_fields[:content_as_html]
      content_entry.generated_fields = {}
      content_entry.save
    end    
  end

  def down
  end
end
