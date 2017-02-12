require "rails_helper"

describe "Logged in User" do
  before do
    @user_1 = create(:registered_user)

    @user_2 = create(:registered_user)
    stub_log_in_user(@user_2)
  end

  it "can follow other users" do
    visit registered_user_path(@user_1.username)
    click_on "Following"

    expect(current_path).to eql(registered_user_path(@user_1.username))
    expect(@user_2.following.count).to eql(1)
    expect(@user_2.following.first).to eql(@user_1)
  end
end
