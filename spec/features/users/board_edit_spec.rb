require "rails_helper"

describe "A User" do
  before do
    user = create(:user)
    stub_log_in_user(user)
    visit user_path
  end

  xit "can edit a board from the board's show page" do
    visit user_board_path(user, board)

    click('Edit')
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
