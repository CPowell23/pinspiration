require "rails_helper"

describe "Logged in Admin" do
  before do
    @user = create(:registered_user)
    @board_1, @board_2 = create_list(:board, 2, registered_user: @user)
    @admin = create(:admin)
    stub_log_in_admin(@admin)
  end

  scenario "admin cannot edit user info" do 
    visit edit_registered_user_path(@user.username)

    expect(page).to have_content("Deactivate Account")
    expect(page).not_to have_content("Edit")
  end

  scenario "admin cannot edit boards" do 
    visit registered_users_edit_board_path(@user.username, @board_2.name)

    expect(page.status_code).to eq(404)
  end

  scenario "admin cannot delete users" do 
    visit edit_registered_user_path(@user.username)

    expect(page).not_to have_content("Delete Account Permanently")
  end
end
  