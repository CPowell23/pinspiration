require 'rails_helper'

describe 'User edits account' do
  before do
    @user1 = create(:registered_user)
    @user2 = create(:registered_user)
    stub_log_in_user(@user1)
  end
  
  it 'that belongs to them' do
    visit edit_registered_user_path(@user1.username)
    fill_in('pinspiration_credential_name', :with => "New Name")
    click_on("Save Settings")

    expect(current_path).to eq(registered_user_path(@user1.username))
    expect(@user1.name).to eq("New Name")
  end

  it 'fails if not valid update' do
    visit edit_registered_user_path(@user1.username)
    fill_in('name', :with => "")
    click_on("Save Settings")
   
    expect(current_path).to eq(edit_registered_user_path(@user1.username))
    expect(page).to have_content("Account update failed. Please check you filled in all required fields")
  end

  it 'fails if not theirs' do
    visit edit_registered_user_path(@user2.username)

    expect(page).to have_content("404")
  end

end
