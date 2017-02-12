require 'rails_helper'

describe 'User can see' do
  before do
    @user = create(:registered_user)
    @username = @user.pinspiration_credentials.first.username
    @board1, @board2, @board3 = create_list(:board, 3, registered_user: @user)
    Board.all.each do |board|
      create_list(:pin, 5, board: board)
    end
  end

  it 'all their Boards' do
    visit registered_users_boards_path(@username)

    @user.boards.each do |board|
      expect(page).to have_content(board.name)
    end
  end

  it 'one of their boards' do
    visit registered_users_board_path(@username, @board1.name)

    @board1.pins.each do |pin|
      expect(page).to have_content(pin.description)
      expect(page).to have_css("img[src*='#{pin.image_url}']")
    end
  end
end
