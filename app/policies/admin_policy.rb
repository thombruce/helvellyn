class AdminPolicy < ApplicationPolicy
  # TODO: Admin permissions are slightly more complex.
  #       Update this file with common permissions.
  #       Consider use of super to extend permissions
  #       or some alternative using Rolify role arrays
  #       that would be less database-hungry.

  # Helper Methods
  def current_workspace
    session.current_workspace
  end
end
