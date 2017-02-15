require 'rails_helper'

describe 'User security' do
  before do
    @user1 = create(:registered_user)
    @user2 = create(:registered_user)
    category = create(:category)
    @private_board = Board.create(name: Faker::Hipster.unique.words(2).join(""), 
                                    description: Faker::Hipster.sentence,
                                    category: category,
                                    registered_user: @user2,
                                    private: true)                               
    @username = @user1.pinspiration_credentials.first.username
    @board1, @board2, @board3 = create_list(:board, 3, registered_user: @user1)
    Board.all.each do |board|
      create_list(:pin, 5, board: board)
    end
    stub_log_in_user(@user1)
  end

  scenario "user cannot see other users' private boards" do
    visit registered_users_boards_path(@private_board.registered_user.username)

    expect(page).not_to have_content(@private_board.name)
  end

  scenario "user cannot edit or see other users' private info" do 
    visit edit_registered_user_path(@user2.username)

    expect(page.status_code).to eq(404)
  end

  scenario "user cannot log in as admin" do 
    visit admin_login_path

    expect(page.status_code).to eq(200)

    fill_in "password", with: "hackingstuff"
    click_on "Log in"

    expect(page).to have_content("Email and password combination does not exist")

    expect(current_path).to eq(admin_login_path)
  end
end