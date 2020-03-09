class ContentTypePolicy < ApplicationPolicy
  def permitted_attributes
    [:name, fields: []]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
