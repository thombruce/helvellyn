class Api::EntityPolicy < ApplicationPolicy
  def show?
    record.published?
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.published
    end
  end
end
