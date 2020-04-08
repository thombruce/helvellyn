class AdminController < ApplicationController
  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end

  def permitted_attributes(record, action = action_name)
    super([:admin, record], action)
  end
end
