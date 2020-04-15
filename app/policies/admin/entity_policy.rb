class Admin::EntityPolicy < AdminPolicy
  def index?
    user&.has_role?([:admin], current_workspace)
  end

  def show?
    record.published? || user&.has_any_role?({ name: :author, resource: record }, { name: :admin, resource: current_workspace })
  end

  def create?
    user&.has_role?(:admin, current_workspace)
  end

  def update?
    user&.has_any_role?({ name: :author, resource: record }, { name: :admin, resource: current_workspace })
  end

  def destroy?
    user&.has_any_role?({ name: :author, resource: record }, { name: :admin, resource: current_workspace })
  end

  class Scope < Scope
    def resolve
      if user
        scope.all
      else
        scope.published
      end
    end
  end
end
