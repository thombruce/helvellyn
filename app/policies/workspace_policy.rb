class WorkspacePolicy < ApplicationPolicy
  def permitted_attributes
    [:title]
  end

  def show?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
