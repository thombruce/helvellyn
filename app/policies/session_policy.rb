class SessionPolicy < ApplicationPolicy
  def permitted_attributes
    [:login, :password]
  end

  def new?
    !user
  end

  def create?
    !user
  end

  def destroy?
    user && user == record.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
