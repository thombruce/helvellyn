class Api::WorkspacePolicy < ApiPolicy
  def show?
    super && workspace == current_workspace # TODO: Add public boolean to workspaces
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
