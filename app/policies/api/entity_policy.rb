class Api::EntityPolicy < ApiPolicy
  def show?
    super && record.published?
  end

  class Scope < Scope
    def resolve
      scope.published
    end
  end
end
