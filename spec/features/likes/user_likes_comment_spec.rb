require 'rails_helper'

describe 'User likes a comment' do
  before do
    @user = create(:registered_user)
    @pin = create(:pin)
    @pin_with_likes = create(:pin)
    @comment = create(:comment, pin: @pin)
    @comment_with_likes = create(:comment, pin: @pin_with_likes)
    create(:comment_like, target: @comment_with_likes, registered_user: @user)
    stub_log_in_user(@user)
  end

  it 'that has not been liked' do
    visit pin_path(@pin)
    within('section.comment') do
      click_on "Like" 
    end

    expect(current_path).to eq(pin_path(@pin))
    expect(@comment.likes.count).to eq(1)
    within('section.comment') do
      expect(page).to have_content("Unlike")
    end
  end

  it 'but cannot like it twice' do
    visit pin_path(@pin_with_likes)

    within('section.comment') do 
      expect(page).to have_content("Unlike")
    end
  end
end
