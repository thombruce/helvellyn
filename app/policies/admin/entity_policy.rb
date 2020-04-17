class Admin::EntityPolicy < AdminPolicy
  def index?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def show?
    record.published? || user == record.created_by || user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def create?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def update?
    user == record.created_by || user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace })
  end

  def destroy?
    user == record.created_by || user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace })
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
