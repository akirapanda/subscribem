require 'rails_helper'

feature "Account" do
  scenario "create an account" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    fill_in  'Name', :with => "Test"
    click_button "Create Account"
    success_message = "Your Account has been successfully created."
    expect(page).to have_content(success_message)
  end
end