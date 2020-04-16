class Admin::TemplatePolicy < AdminPolicy
  def permitted_attributes
    [
      :name,
      :plural,
      :slug,
      :publishable,
      :sluggable_field,
      :api_sort,
      :api_desc,
      :admin_sort,
      :admin_desc,
      fields: [
        :name,
        :slug,
        :type
      ]
    ]
  end

  def index?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def show?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def create?
    user&.has_role?(:admin, current_workspace)
  end

  def update?
    user&.has_role?(:admin, current_workspace)
  end

  def destroy?
    user&.has_role?(:admin, current_workspace)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
