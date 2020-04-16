class Admin::SettingsPolicy < AdminPolicy
  def permitted_attributes
    [:name, :hostname, :email]
  end

  def show?
    user&.has_role?(:admin)
  end

  def public?
    true
  end

  def update?
    user&.has_role?(:admin)
  end
end
