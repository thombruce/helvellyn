class Api::EntityPolicy < ApiPolicy
  def index?
    super && workspace == current_workspace
  end

  def show?
    super && workspace == current_workspace && record.published?
  end

  class Scope < Scope
    def resolve
      scope.published
    end
  end
end
