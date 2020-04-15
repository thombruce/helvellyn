class Authentication::SessionPolicy < AuthenticationPolicy
  def permitted_attributes
    [:login, :password]
  end

  def update?
    user && user == record.user
  end
end
