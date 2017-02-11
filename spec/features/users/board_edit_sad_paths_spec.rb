require "rails_helper"

describe "Board Edit Errors" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    @username = @user.pinspiration_credentials.first.username
    category = create(:category)
    @board = create(:board, registered_user: @user, category_id: category.id)
  end

  it "is unable to edit other user's boards by button" do
    user_2 = create(:registered_user)
    board_2 = create(:board, name: "Authentic")

    visit registered_users_board_path(user_2.pinspiration_credentials.first.username, board_2.name)

    expect(page).not_to have_content('Edit')
  end

  it "is unable to edit other user's boards by url" do
    user_2 = create(:registered_user)
    board_2 = create(:board, name: "Authentic")

    visit registered_users_edit_board_path(user_2.pinspiration_credentials.first.username, board_2.name)

    expect(page).to have_content('404')
  end

  it "is unable to save board without name" do
    visit registered_users_edit_board_path(@username, @board.name)

    within "form" do
      fill_in "board[name]", with: nil
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(page).to have_content('Edit Your Board')
    expect(page).to have_content("Name can't be blank")
  end

  xit "is unable to save board without description" do
    visit registered_users_edit_board_path(@username, @board.name)

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: nil
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(page).to have_content('Edit Your Board')
    expect(page).to have_content("Description can't be blank")
  end
end
