class Admin::SettingsPolicy < ApplicationPolicy
  def permitted_attributes
    [:name]
  end

  def show?
    user&.has_role?(:admin)
  end

  def update?
    user&.has_role?(:admin)
  end
end
