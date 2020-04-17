class PrepareDataForModifiedRichTextEditorOnEntities < ActiveRecord::Migration[6.0]
  def change
    Entity.find_each do |entity|
      entity.data[:content] = { html: entity.data[:content] }
      entity.save
    end
  end
end
