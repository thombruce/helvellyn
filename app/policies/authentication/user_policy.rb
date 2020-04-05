class Authentication::UserPolicy < ApplicationPolicy
  def permitted_attributes
    [:name, :email, :password]
  end

  def show?
    user && user == record
  end

  def create?
    !user
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
