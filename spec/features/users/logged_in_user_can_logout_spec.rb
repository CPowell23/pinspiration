require 'rails_helper'

describe "Logged in user workflow" do
  context "as a logged in user" do
   scenario "I can login with pinspiration credentials and then logout" do
      visit root_path

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome to Pinspirations")

      click_on("Log in")
      
      click_on("Logout")

      expect(current_path).to eq(root_path)
    end

   scenario "I can login with google credentials and then logout" do
      visit root_path
      stub_omniauth
      click_on("Google SignIn")

      expect(page.status_code).to eq(200)
      click_on("Logout")

      expect(current_path).to eq(root_path)
    end
  end
end