require "rails_helper"

describe "Pin Delete" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    board = create(:board, registered_user: @user)
    @pin = create(:pin, board: board)
    create_list(:comment, 3, pin: @pin)
  end

  it "logged in user can delete pin and it's comments" do
    visit pin_path(@pin)
    click_on "Edit"
    click_on "Delete"

    expect(current_path).to eql(registered_users_pins_path(@user.username))
    expect(Pin.count).to eql(0)
    expect(Comment.count).to eql(0)
  end

end
