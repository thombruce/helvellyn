class ApiController < ApplicationController
  def policy_scope(scope)
    super([:api, scope])
  end

  def authorize(record, query = nil)
    super([:api, record], query)
  end

  def permitted_attributes(record, action = action_name)
    super([:api, record], action)
  end
end
