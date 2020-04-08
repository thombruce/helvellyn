require 'rails_helper'

RSpec.describe "Authentication::Users", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "renders a title" do
    visit "/signup"

    expect(page).to have_text("New User")
  end
end
