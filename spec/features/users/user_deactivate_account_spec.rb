require 'rails_helper'

describe 'User deactives account' do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
  end

  it 'from edit path' do
    visit edit_registered_user_path(@user.username)
    click_on "Deactivate Account"
    
    expect(current_path).to eq('/login')
    expect(@user.status).to eq('offline')
  end
end
