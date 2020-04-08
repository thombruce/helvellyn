class Admin::ContentEntryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || user&.has_any_role?({ name: :author, resource: record }, { name: :admin, resource: workspace })
  end

  def create?
    user&.has_role?(:admin, workspace)
  end

  def update?
    user&.has_any_role?({ name: :author, resource: record }, { name: :admin, resource: workspace })
  end

  def destroy?
    user&.has_any_role?({ name: :author, resource: record }, { name: :admin, resource: workspace })
  end

  # Helper Methods
  def workspace
    record.content_type.workspace
  end

  class Scope < Scope
    def resolve
      if user
        scope.all
      else
        scope.published
      end
    end
  end
end
