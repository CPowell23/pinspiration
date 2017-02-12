require 'rails_helper'

describe 'User unlikes pin' do
  before do
    @user = create(:registered_user)
    @user_board = create(:board, registered_user: @user)
    @user_pin = create(:pin, board: @user_board)
    @board = create(:board)
    @pin = create(:pin, board: @board)
    @pin_with_likes = create(:pin, board: @board)
    create(:pin_like, registered_user: @user, target: @pin_with_likes)
    stub_log_in_user(@user)
  end

  it 'has not been liked yet' do
    visit pin_path(@pin)

    expect(page).to_not have_content("Unlike")
  end

  it 'has been liked' do
    visit pin_path(@pin_with_likes)
    click_on("Unlike")

    expect(current_path).to eq(pin_path(@pin_with_likes))
    expect(page).to have_content("Like")
  end
end
