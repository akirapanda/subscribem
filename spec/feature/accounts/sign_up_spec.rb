require 'rails_helper'

feature "Account" do
  scenario "create an account" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    
    fill_in  'Name', :with => "Test"
    fill_in  'Subdomain', :with => "test"
    fill_in  'Email',:with => "subscribem@example.com"
    fill_in  'Password', :with=> "password"
    fill_in  'Password confirmation', :with => "password"

    click_button "Create Account"
    success_message = "Signed in as subscribem@example.com."
    expect(page).to have_content(success_message)
    expect(page.current_url).to eq("http://test.example.com/")
  end

  scenario "ensure subdomain uniqueness" do
    #create an exist subdomain at first
    Subscribem::Account.create!(:subdomain=>"test",:name=>"Test")

    #Create same subdomain via form
    visit subscribem.root_path
    click_link "Account Sign Up"

    fill_in  'Name', :with => "Test"
    fill_in  'Subdomain', :with => "test"
    fill_in  'Email',:with => "subscribem@example.com"
    fill_in  'Password', :with=> "password"
    fill_in  'Password confirmation', :with => "password"

    click_button "Create Account"

    expect(page.current_url).to eq("http://www.example.com/accounts")

    expect(page).to have_content("Sorry,your account could not be created.")
    expect(page).to have_content("Subdomain has already been taken")

  end

  scenario "subdomain with restricted name" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    
    fill_in  'Name', :with => "Test"
    fill_in  'Subdomain', :with => "admin"
    fill_in  'Email',:with => "subscribem@example.com"
    fill_in  'Password', :with=> "password"
    fill_in  'Password confirmation', :with => "password"

    click_button "Create Account"

    expect(page.current_url).to eq("http://www.example.com/accounts")
    expect(page).to have_content("Sorry,your account could not be created.")
    expect(page).to have_content("Subdomain is not allowed.Please choose another subdomain.")
  end

  scenario "subdomain with invalid name" do
    visit subscribem.root_path
    click_link "Account Sign Up"
    
    fill_in  'Name', :with => "Test"
    fill_in  'Subdomain', :with => "<admin>"
    fill_in  'Email',:with => "subscribem@example.com"
    fill_in  'Password', :with=> "password"
    fill_in  'Password confirmation', :with => "password"

    click_button "Create Account"

    expect(page.current_url).to eq("http://www.example.com/accounts")
    expect(page).to have_content("Sorry,your account could not be created.")
    expect(page).to have_content("Subdomain is not allowed.Please choose another subdomain.")
  end

end