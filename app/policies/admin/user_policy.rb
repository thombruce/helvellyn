class Admin::UserPolicy < AdminPolicy
  def index?
    user&.has_role?([:admin], workspace)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
