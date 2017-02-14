require 'rails_helper'

describe 'Admin deactivates users account' do
  before do
    @admin = create(:admin)
    @user = create(:registered_user)
    stub_log_in_admin(@admin)
  end
  
  it 'using edit button' do
    visit edit_registered_user_path(@user.username)
    click_on 'Deactivate Account'
    @user.reload

    expect(current_path).to eq(edit_registered_user_path(@user.username))
    expect(@user.status).to eq('offline')
    expect(page).to have_content("Account offline")
  end
end
