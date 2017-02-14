require 'rails_helper'

describe 'User deactives account' do
  before do
    @user1 = create(:registered_user)
    @user2 = create(:registered_user)
    stub_log_in_user(@user2)
  end

  it 'from edit path' do
    visit edit_registered_user_path(@user2.username)
    click_on "Deactivate Account"
    @user2.reload

    expect(current_path).to eq('/login')
    expect(@user2.status).to eq('offline')
  end

  it 'cannot deactivate another users account' do
    visit edit_registered_user_path(@user1.username)

    expect(page).to have_content('404')
  end
end
