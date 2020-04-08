require 'rails_helper'

RSpec.describe "Authentication::Sessions", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "renders a title" do
    visit "/login"

    expect(page).to have_text("New Session")
  end
end
