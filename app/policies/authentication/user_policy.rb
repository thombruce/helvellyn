class Authentication::UserPolicy < AuthenticationPolicy
  def permitted_attributes
    [:name, :email, :password]
  end

  def update?
    user && user == record
  end
end
