require "rails_helper"

describe "A logged in user" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    @board = create(:board, registered_user_id: @user.id)
  end

  it "can delete their own board from the board's show page" do
    visit registered_users_board_path(@user.username, @board.name)

    expect(page).to have_content('Delete')

    click_on('Delete')

    expect(page).to have_content("Successfully deleted board")
    expect(page).not_to have_content(@board.name)
    expect(current_path).to eq(registered_users_boards_path(@user.username))
  end

  it "cannot delete another user's board" do
    user_2 = create(:registered_user)
    board_2 = create(:board, registered_user_id: user_2.id)

    visit registered_users_board_path(user_2.username, board_2.name)

    expect(page).not_to have_content('Delete')
  end
end
