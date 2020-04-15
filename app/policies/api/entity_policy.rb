class Api::EntityPolicy < ApiPolicy
  # TODO: Lack of authentication on index means that these
  #       are accessible without an API-Token.

  def show?
    super && record.published?
  end

  class Scope < Scope
    def resolve
      scope.published
    end
  end
end
