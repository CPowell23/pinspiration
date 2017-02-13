require 'rails_helper'

describe 'User unlikes board' do
  before do
    @user = create(:registered_user)
    @user_board = create(:board, registered_user: @user)
    @board = create(:board)
    @board_with_likes = create(:board)
    create(:board_like, target: @board_with_likes, registered_user: @user)
    stub_log_in_user(@user)
  end
  
  it 'that they already liked' do
    visit registered_users_board_path(@board_with_likes.registered_user.username, @board_with_likes.name)
    click_on "Unlike"

    expect(@board_with_likes.likes.count).to eq(0)
    expect(current_path).to eq(registered_users_board_path(@board_with_likes.registered_user.username, @board_with_likes.name))
    expect(page).to have_content("Like")
  end

  it 'cannot unlike board not already liked' do
    visit registered_users_board_path(@board.registered_user.username, @board.name)

    expect(page).to_not have_content("Unlike")
  end
end
