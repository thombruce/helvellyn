class AuthenticationController < ApplicationController
  def policy_scope(scope)
    super([:authentication, scope])
  end

  def authorize(record, query = nil)
    super([:authentication, record], query)
  end

  def permitted_attributes(record, action = action_name)
    super([:authentication, record], action)
  end
end
