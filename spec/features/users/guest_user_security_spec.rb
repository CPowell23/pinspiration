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
    end

    scenario "can see public pins on public boards via url" do 
      visit registered_users_boards_path(@user.username)

      expect(page.status_code).to eq(200)
    end

    scenario "cannot see private boards or pins" do 
      visit registered_users_boards_path(@private_board.registered_user.username)

      expect(page.status_code).to eq(200)
    end

    
#see other users' private account information
#follow users
#log themselves in as an admin
#set users to online / offline
#create, edit, or delete pins / boards / comments made by other users
  end
end