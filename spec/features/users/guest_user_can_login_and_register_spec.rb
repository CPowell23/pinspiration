require 'rails_helper'

describe "Guest login workflow" do
  context "An unregisted guest" do
    it "can visit the app home page" do
      visit root_path

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_button("Continue")
      # expect(page).to have_button("Continue with Google")
    end

    it "can create a new registration for the app using pinspiration credentials" do
      visit root_path

      fill_in "Email", with: "jane@janemail.com"
      fill_in "Password", with: 'password01'
      click_button("Continue")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("janedoe successfully created!")
    end

    xit "cannot create a new registration for the app with invalid credentials" do
      visit root_path

      fill_in "Email", with: ""
      fill_in "Password", with: 'password01'
      click_button("Continue")

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Missing needed credentials or passwords do not match!")
    end

    xit "can login to the app with an existing account" do
    end

    xit "cannot login to the app with invalid credentials" do
    end
  end
end
