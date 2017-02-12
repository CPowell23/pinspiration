require 'rails_helper'

describe 'User likes a board' do
  before do
    @user = create(:registered_user)
    @user_board = create(:board, registered_user: @user)
    @board = create(:board)
    @board_with_likes = create(:board)
    create(:board_like, target: @board_with_likes, registered_user: @user)
    stub_log_in_user(@user)
  end

  it 'that has not been liked' do
    visit registered_users_board_path(@board.registered_user.username, @board.name)
    click_on "Like"

    expect(current_path).to eq(registered_users_board_path(@board.registered_user.username, @board.name))
    expect(page).to have_content("Unlike")
    expect(@board.likes.count).to eq(1)
  end

  it 'cannot if it belongs to them' do
    visit registered_users_board_path(@user.username, @user_board.name)

    expect(page).to_not have_content("Like")
    expect(page).to_not have_content("Unlike")
  end

  it 'cannot if it has already been liked' do
    visit registered_users_board_path(@board_with_likes.registered_user.username, @board_with_likes.name)

    expect(page).to have_content("Unlike")
  end
end
