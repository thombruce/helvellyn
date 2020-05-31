module SystemSpecHelper
  def self.included(base)
    base.before(:each) { driven_by(:selenium_chrome_headless) }
  end

  def signup
    visit "/signup"
    fill_in "Name", :with => "John Smith"
    fill_in "Email", :with => "john.smith@example.com"
    fill_in "Password", :with => "Passw0rd123!"
    click_button "Sign up"
  end

  def login
    create(:user, name: 'John Smith', email: 'john.smith@example.com', password: 'Passw0rd123!')

    visit "/login"
    fill_in "Login", :with => "john.smith@example.com"
    fill_in "Password", :with => "Passw0rd123!"
    click_button "Log in"
  end

  def sign_out
    # TODO
  end
end
