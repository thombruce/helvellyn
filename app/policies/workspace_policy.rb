class WorkspacePolicy < ApplicationPolicy
  def permitted_attributes
    [:title]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
