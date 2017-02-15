require 'rails_helper'

describe 'User deletes account' do
  before do
    @user1 = create(:registered_user)
    @user2 = create(:registered_user)
    @admin = create(:admin)
  end

  it 'by clicking link on edit page' do
    stub_log_in_user(@user1)
    visit edit_registered_user_path(@user1.username)
    click_on "Delete Account Permanently"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Account successfully deleted")
  end

  it 'cannot delete another users account' do
    stub_log_in_user(@user2)
    visit edit_registered_user_path(@user1.username)
    
    expect(page).to have_content('404')
  end

  it 'admin cannot delete account' do
    stub_log_in_admin(@admin)
    visit edit_registered_user_path(@user1.username)
    
    expect(page).to_not have_content("Delete Account Permanently")
  end

end
