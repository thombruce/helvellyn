class ContentEntryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user || record.published?
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
