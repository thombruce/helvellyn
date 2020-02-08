class PostPolicy < ApplicationPolicy
  def permitted_attributes
    [:content]
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    user && user == record.user
  end

  def update?
    user && user == record.user
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
