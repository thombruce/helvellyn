class ApiPolicy < ApplicationPolicy
  # The public API disallows all mutations. Only
  # READ operations are currently allowed.
  def index?
    workspace
  end

  def show?
    workspace
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  # Helper Methods
  def workspace
    session.workspace
  end

  def current_workspace
    session.current_workspace
  end
end
