require 'rails_helper'

describe 'User can view account information' do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    visit registered_user_path(@user) 
  end

  it 'by using account icon' do
    expect(current_path).to eq("/#{@user.username}")
    expect(page).to have_content("Account Profile")
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Boards")
    expect(page).to have_content("Pins")
    expect(page).to have_content("Likes")
  end
end
