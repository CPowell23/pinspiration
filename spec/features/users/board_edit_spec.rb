require "rails_helper"

describe "A User" do
  before do
    @user = create(:registered_user)
    stub_log_in_registered_user(@user)
    @username = @user.pinspiration_credentials.first.username
    @board = create(:board, registered_user: @user)
  end

  it "can edit a board from the board's show page" do
    visit registered_users_path(@username, @board.name)

    click_on('Edit')

    expect(current_path).to eq(registered_users_edit_board_path(username, @board.name))
  end

  xit "can edit a board from the board index page" do
    visit user_boards_path(user)
  end

  xit "can edit all fields for the board" do

  end

  xit "is unable to edit other user's boards by button" do
    expect(page).not_to have_content('Edit')
  end

  xit "is unable to edit other user's boards by url" do
    get '/'

    expect(page).to have_content('ERROR ERROR')
  end
end
