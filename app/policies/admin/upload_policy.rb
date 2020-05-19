class Admin::UploadPolicy < AdminPolicy
  def permitted_attributes
    [:file]
  end

  def index?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def show?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def create?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def update?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace })
  end

  def destroy?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace })
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
