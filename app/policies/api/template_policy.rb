class Api::TemplatePolicy < ApiPolicy
  def show?
    super && record.publishable
  end

  class Scope < Scope
    def resolve
      scope.where(publishable: true)
    end
  end
end
