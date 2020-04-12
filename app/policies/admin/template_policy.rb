class Admin::TemplatePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :name,
      :plural,
      :slug,
      :publishable,
      :sluggable_field,
      :sort,
      :desc,
      fields: [
        :name,
        :slug,
        :type
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
