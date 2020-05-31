require 'rails_helper'

RSpec.describe "Authentication::Sessions", type: :system do
  it "renders a title" do
    visit "/login"

    expect(page).to have_text("New Session")
  end

  it "allows login with valid user" do
    login # spec/support/system_spec_helper.rb
    expect(page).to have_text("Workspaces")
  end
end
