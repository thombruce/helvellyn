class Authentication::UserPolicy < AuthenticationPolicy
  def permitted_attributes
    [:name, :email, :password]
  end

  def confirm?
    true
  end

  def update?
    user && user == record
  end
end
