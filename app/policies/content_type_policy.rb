class ContentTypePolicy < ApplicationPolicy
  def permitted_attributes
    [
      :name,
      :plural,
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
