require 'rails_helper'

describe 'User likes a pin' do
  before do
    @user = create(:registered_user)
    @user_board = create(:board, registered_user: @user)
    @user_pin = create(:pin, board: @user_board)
    @board = create(:board)
    @pin = create(:pin, board: @board)
    stub_log_in_user(@user)
  end

  it 'belonging to another user' do
    visit pin_path(@pin)
    click_on "Like"

    expect(current_path).to eq(pin_path(@pin))
    expect(page).to have_content("Unlike")
    expect(@pin.likes.count).to eq(1)
  end

  it 'cannot if it is their own pin' do
    visit pin_path(@user_pin)

    expect(page).to_not have_content("Like")
  end
end
