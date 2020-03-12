class ContentTypePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :name,
      :slug,
      fields: [
        :name,
        :type
      ]
    ]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
