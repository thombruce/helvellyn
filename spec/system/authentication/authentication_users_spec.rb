require 'rails_helper'

RSpec.describe "Authentication::Users", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "enables me to create widgets" do
    visit "/login"

    expect(page).to have_text("New Session")
  end
end
