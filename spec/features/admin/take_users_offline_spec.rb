require "rails_helper"

describe "Logged in admin" do
  before do
    admin = create(:admin)
    stub_log_in_admin(admin)
  end

  it "can take a user offline" do
    @user = create(:registered_user, status: "online")
    visit registered_user_path(@user)
    expect(page).not_to have_selector(:link_or_button, "Put User Online")
    click_on "Take User Offline"

    expect(@user.status).to eql("offline")
    stub_admin_logout(admin)

    # make sure guest users cannot see the user's content
    visit registered_users_boards_path(@user.username)
    expect(page).to have_content("The page you are looking for does not exist.")
    visit pins_index_path(@user.username)
    expect(page).to have_content("The page you are looking for does not exist.")

    # make sure the user cannot login
    visit login_path
    fill_in "registered_user[email]", with: @user.email
    fill_in "registered_user[password]", with: "password"
    expect(page).to have_content("Your account is deactivated at this time.")

    # but make sure their content still exists in the database
    expect(@user.boards.count).to be > 0
    expect(@user.pins.count).to be > 0
  end

  it "can put a user back online" do
    @user = create(:registered_user, status: "offline")
    visit registered_user_path(@user)
    expect(page).not_to have_selector(:link_or_button, "Take User Offline")
    click_on "Put User Online"

    expect(@user.status).to eql("online")
    stub_admin_logout(admin)

    # make sure user can login by inputting their login credentials
    visit login_path
    fill_in "registered_user[email]", with: @user.email
    fill_in "registered_user[password]", with: "password"
    expect(current_path).to eql(registered_user_dashboard_path(@user.username))

    stub_user_logout(@user)
    user_boards = @user.boards
    user_pins = @user.pins

    # make sure guest users CAN see the user's content
    visit registered_users_boards_path(@user.username)
    user_boards.each do |board|
      expect(page).to have_content(board.name)
    end
    visit pins_index_path(@user.username)
    user_pins.each do |pin|
      expect(page).to have_content(pin.description)
    end
  end
end
