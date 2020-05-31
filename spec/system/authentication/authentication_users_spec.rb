require 'rails_helper'

RSpec.describe "Authentication::Users", type: :system do
  it "renders a title" do
    visit "/signup"

    expect(page).to have_text("New User")
  end

  it "allows signup" do
    signup # spec/support/system_spec_helper.rb
    expect(page).to have_text("Workspaces")
  end
end
