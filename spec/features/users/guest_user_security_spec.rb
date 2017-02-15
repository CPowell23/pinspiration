require 'rails_helper'

describe "Guest user workflow" do
  context "An unregisted guest" do
    before do 
      category = create(:category)
      @user = create(:registered_user)
      @user.boards.create(name: Faker::Hipster.unique.words(2).join(""), 
                                    description: Faker::Hipster.sentence,
                                    category: category,
                                    registered_user: @user,
                                    private: false)
      @private_board = Board.create(name: Faker::Hipster.unique.words(2).join(""), 
                                    description: Faker::Hipster.sentence,
                                    category: category,
                                    registered_user: @user,
                                    private: true)
      @pins = Pin.create(description: "best ever pin",
                        image_url: "https://s-media-cache-ak0.pinimg.com/564x/90/5d/a9/905da92511ef7e18b65e5c62cf1db38c.jpg",
                        article_url: "http://www.ravelry.com/patterns/library/black-roxy",
                        board: @private_board),
              Pin.create(description: "next best ever pin",
                        image_url: "https://s-media-cache-ak0.pinimg.com/564x/90/5d/a9/905da92511ef7e18b65e5c62cf1db38c.jpg",
                        article_url: "http://www.ravelry.com/patterns/library/black-roxy",
                        board: @private_board)
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
      visit registered_users_boards_path(@private_board.registered_user.username)

      expect(page).not_to have_content(@private_board.name)
    end

    scenario "cannot edit boards" do 
      visit registered_users_boards_path(@user.username)

      expect(page).not_to have_button("Edit")
    end

    scenario "cannot create boards" do 
      visit new_registered_users_board_path(@user.username)

      expect(page.status_code).to eq(404)
    end

    scenario "cannot delete boards or pins" do 
      visit registered_users_boards_path(@user.username)

      expect(page).not_to have_content("Delete")
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