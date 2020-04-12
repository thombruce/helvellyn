class ResetEntitiesCountersOnTemplates < ActiveRecord::Migration[6.0]
  def up
    Template.find_each do |template|
      Template.reset_counters(template.id, :entities)
    end
  end

  def down
  end
end
