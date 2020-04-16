class Admin::UserPolicy < AdminPolicy
  def permitted_attributes # TODO: Different per invite and update actions
    [:email, :role]
  end

  def index?
    user&.has_any_role?({ name: :admin, resource: current_workspace }, { name: :moderator, resource: current_workspace }, { name: :author, resource: current_workspace })
  end

  def invite?
    user&.has_role?([:admin], current_workspace)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
