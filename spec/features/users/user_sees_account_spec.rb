require 'rails_helper'

describe 'User can view account information' do
  it 'by using account icon' do
    user = create(:registered_user)
    stub_log_in_user(user)
    visit root_path
    click_on("Log in")

    expect(current_path).to eq('/#{user.username}/dashboard')
    # expect(page).to have_content(user.name)
    # expect(page).to have_content("Boards")
    # expect(page).to have_content("Pins")
    # expect(page).to have_content("Likes")
    find('i.fa.fa-user').click

    expect(current_path).to eq(root_path)
  end
end
