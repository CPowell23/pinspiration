require 'rails_helper'

describe 'User sees all likes' do
  before do
    @user1, @user2 = create_list(:registered_user, 2)
    @pin = create(:pin)
    @board = create(:board)
    RegisteredUser.all.each do |user|
      create(:pin_like, registered_user: user, target: @pin)
      create(:board_like, registered_user: user, target: @board)
    end
    stub_log_in_user(@user1)
  end

  it 'belonging to them' do
    visit registered_users_likes_path(@user1.username)

    expect(page).to have_content(@pin.description)
    expect(page).to have_content(@board.name)
  end

  it 'belonging to someone else' do
    visit registered_users_likes_path(@user2.username)

    expect(page).to have_content(@pin.description)
    expect(page).to have_content(@board.name)
  end
end
