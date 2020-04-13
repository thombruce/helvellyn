class Api::TemplatePolicy < ApplicationPolicy
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
    record.publishable
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
      scope.where(publishable: true)
    end
  end
end
