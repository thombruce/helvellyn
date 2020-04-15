class Api::TemplatePolicy < ApiPolicy
  def index?
    super && workspace == current_workspace
  end

  def show?
    super && workspace == current_workspace && record.publishable
  end

  class Scope < Scope
    def resolve
      scope.where(publishable: true)
    end
  end
end
