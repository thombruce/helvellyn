class MigrateSluggableBooleanToSluggableField < ActiveRecord::Migration[6.0]
  def up
    Template.find_each do |template|
      if field = template.fields.find { |field| field[:sluggable] }
        template.sluggable_field = field[:slug]
        template.save
      end
    end
  end

  def down
  end
end
