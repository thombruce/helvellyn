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
    user&.has_role?([:admin], workspace)
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

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
