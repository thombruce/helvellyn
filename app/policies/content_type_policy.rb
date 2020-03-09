class ContentTypePolicy < ApplicationPolicy
  def permitted_attributes
    [:name]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
