class ContentTypePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :name,
      :slug,
      fields: [
        :name,
        :type,
        :sluggable
      ]
    ]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
