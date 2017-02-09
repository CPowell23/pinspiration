require "rails_helper"

describe "A User" do
  before do
    user = create(:user)
    stub_log_in_user(user)
    visit user_path
  end

  xit "can click 'new board' link on the board index page" do

  end

  xit "can enter board information" do
    
  end

  xit "is redirected to the new board's show page" do
    expect(current_path).to eq(user_board_path(user, board))
  end

  xit "and the board belongs to the user" do
    expect(board.user).to eq(user)
  end
end
