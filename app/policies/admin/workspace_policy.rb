class Admin::WorkspacePolicy < AdminPolicy
  def permitted_attributes
    [:title, :slug]
  end

  def show?
    user&.has_any_role?({ name: :admin, resource: record }, { name: :moderator, resource: record }, { name: :author, resource: record })
  end

  def update?
    user&.has_role?(:admin, record)
  end

  def token?
    user&.has_role?(:admin, record)
  end

  def destroy?
    user&.has_role?(:admin, record)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
