class UserPolicy < ApplicationPolicy
  def permitted_attributes
    [:name, :email, :password]
  end

  def new?
    !user
  end

  def create?
    !user
  end

  def edit?
    user && user == record
  end

  def update?
    user && user == record
  end

  def destroy?
    user && user == record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
