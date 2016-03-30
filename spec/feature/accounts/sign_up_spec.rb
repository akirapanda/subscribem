require 'rails_helper'

feature "Account" do
  scenario "create an account" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    
    fill_in  'Name', :with => "Test"
    fill_in  'Subdomain', :with => "Test"
    fill_in  'Email',:with => "subscribem@example.com"
    fill_in  'Password', :with=> "password"
    fill_in  'Password confirmation', :with => "password"

    click_button "Create Account"
    success_message = "Signed in as subscribem@example.com."
    expect(page).to have_content(success_message)
    expect(page.current_url).to eq("http://test.example.com/subscribem/")
  end
end