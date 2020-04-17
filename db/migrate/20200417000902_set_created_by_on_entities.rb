class SetCreatedByOnEntities < ActiveRecord::Migration[6.0]
  # TODO: Delete this file in migrations tidy-up
  def up
    Entity.find_each do |entity|
      entity.created_by = User.first
      entity.save
    end

    Role.where(resource_type: 'Entity').destroy_all
  end

  def down
  end
end
