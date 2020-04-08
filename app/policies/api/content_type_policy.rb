class Api::ContentTypePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :name,
      :plural,
      :slug,
      :publishable,
      fields: [
        :name,
        :type,
        :sluggable
      ]
    ]
  end

  def show?
    user&.has_any_role?({ name: :admin, resource: workspace }, { name: :moderator, resource: workspace }, { name: :member, resource: workspace })
  end

  def create?
    user&.has_role?(:admin, workspace)
  end

  def update?
    user&.has_role?(:admin, workspace)
  end

  def destroy?
    user&.has_role?(:admin, workspace)
  end

  # Helper Methods
  def workspace
    record.workspace
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
