require 'rails_helper'

describe "Guest user workflow" do
  context "An unregisted guest" do
    before do 
      @board = create(:board)
      category = create(:category)
      @user = create(:registered_user)
      @private_board = Board.create(name: Faker::Hipster.unique.words(2).join(""), 
                                    description: Faker::Hipster.sentence,
                                    category: category,
                                    registered_user: @user,
                                    private: true)
    end

   scenario "can visit the app login page" do
      visit login_path

      expect(current_path).to eq('/login')
      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_button("Continue")
      expect(page).to have_button("Google Sign In")
      expect(page).not_to have_selector(:link_or_button, "Log out")
    end

    scenario "can see public pins on public boards via url" do 
      visit registered_users_boards_path(@user.username)

      expect(page.status_code).to eq(200)
    end

    scenario "cannot see private boards or pins" do 
      visit registered_users_boards_path(@private_board)

      expect(page.status_code).to eq(404)
    end

    scenario "cannot see users' private account info" do 
      visit pinspiration_credentials_path
    end

    scenario "cannot edit boards" do 
    end
    scenario "cannot create boards" do 
    end
    scenario "cannot delete boards or pins" do 
    end

    scenario "cannot follow users" do 
      visit registered_users_boards_path(@user.username)

      expect(page).not_to have_button("Follow")
    end

    scenario "cannot see admin content" do 
      visit admin_login_path

      expect(page.status_code).to eq(200)
      expect(page).not_to have_selector(:link_or_button, "Log out")

      fill_in "password", with: "hackingstuff"
      click_on "Log in"

      expect(page).to have_content("Email and password combination does not exist")

      expect(current_path).to eq(admin_login_path)
    end

  end
end