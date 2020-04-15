class Admin::WorkspacePolicy < ApplicationPolicy
  def permitted_attributes
    [:title, :slug]
  end

  def show?
    true
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
