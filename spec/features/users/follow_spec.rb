require "rails_helper"

describe "Logged in User" do
  before do
    @user_1 = create(:registered_user)

    @user_2 = create(:registered_user)
    stub_log_in_user(@user_2)
  end

  it "can follow other users" do
    visit registered_user_path(@user_1.username)
    expect(page).not_to have_link("Unfollow")
    click_on "Follow"

    expect(current_path).to eql(registered_user_path(@user_1.username))
    expect(page).to have_content("You are now following this user")
    expect(@user_2.followings.count).to eql(1)
    expect(@user_2.followings.first).to eql(@user_1)
  end

  it "canNOT follow themselves" do
    visit registered_user_path(@user_2.username)

    expect(page).not_to have_link("Follow", href: registered_users_following_create_path(@user_2.username, @user_2.username))
  end

  it "can see all of the users they are following" do
    visit registered_user_path(@user_1.username)
    click_on "Follow"

    user_3 = create(:registered_user)
    visit registered_user_path(user_3.username)
    click_on "Follow"

    visit registered_user_path(@user_2.username)
    click_on "Following"

    expect(page).to have_css(".follower", count: 2)
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(user_3.name)
  end

  it "can see all of their followers" do
    visit registered_user_path(@user_1.username)
    click_on "Follow"
    stub_logout_user(@user_2)

    user_3 = create(:registered_user)
    stub_log_in_user(user_3)
    visit registered_user_path(@user_1.username)
    click_on "Follow"
    stub_logout_user(user_3)

    visit registered_user_path(@user_1.username)
    click_on "Followers"

    expect(page).to have_css(".follower", count: 2)
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(user_3.name)
  end

  context "can UNfollow users they are currently following" do
    it "from the individual user path" do
      visit registered_user_path(@user_1.username)
      click_on "Follow"
      click_on "Unfollow"

      expect(current_path).to eql(registered_user_path(@user_1.username))
      expect(page).to have_content("You are no longer following this user")
      expect(@user_2.followings.count).to eql(0)
    end

    it "from the following index page" do
      visit registered_user_path(@user_1.username)
      click_on "Follow"
      visit registered_users_following_path(@user_2.username)
      click_on "Unfollow"

      expect(current_path).to eql(registered_users_following_path(@user_2.username))
      expect(@user_2.followings.count).to eql(0)
    end
  end
end
