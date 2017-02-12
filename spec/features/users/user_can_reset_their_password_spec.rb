require 'rails_helper'

describe "Registed user who is not yet logged in" do
  context "as a registered user" do
    scenario "I can reset my password" do
      # @user = create(:registered_user)

      visit login_path
      click_link("Forgot your password?")

      expect(current_path).to eq(password_reset_path)

      expect(page).to have_content("Let’s find your Pinterest account")
      fill_in :search, with: "janedoe97"
      click_button("Search")

      expect(current_path).to eq(password_confirmation_path)
      # expect(page).to have_content("Account Profile")
      # expect(page).to have_content(@user.name)
      #
      # click_on("Log out")
      #
      # expect(current_path).to eq(login_path)
    end


  end
end
