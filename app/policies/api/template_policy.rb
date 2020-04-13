class Api::TemplatePolicy < ApplicationPolicy
  def show?
    record.publishable
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
      scope.where(publishable: true)
    end
  end
end
