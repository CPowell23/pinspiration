require 'rails_helper'

describe 'User can view account information' do
  it 'by using account icon' do
    user = create(:registered_user)
    stub_log_in_user(user)
    visit root_path
    find('i.fa.fa-user').click

    save_and_open_page
    expect(current_path).to eq('/#{user.username}')
    expect(page).to have_content(user.name)
    expect(page).to have_content("Boards")
    expect(page).to have_content("Pins")
    expect(page).to have_content("Likes")
  end
end
