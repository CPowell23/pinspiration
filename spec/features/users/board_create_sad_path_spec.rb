require "rails_helper"

describe "Board Create Errors" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
  end

  xit "cannot create a board without a name" do
    visit registered_users_new_board_path(@username)

    within "form" do
      fill_in "board[name]", with: nil
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

  end

  xit "cannot create a board without a description" do

  end

  xit "cannot create a board without a category" do

  end
end
