require "rails_helper"

describe "A User" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    @username = @user.pinspiration_credentials.first.username
    category = create(:category)
    @board = create(:board, registered_user: @user, category_id: category.id)
  end

  it "can edit a board from the board's show page" do
    visit registered_users_board_path(@username, @board.name)

    click_on('Edit')

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
  end

  it "can edit a board from the board index page" do
    visit registered_users_boards_path(@username)

    click_on('Edit')

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
  end

  it "can edit all fields for the board" do
    visit registered_users_edit_board_path(@username, @board.name)

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(current_path).to eq(registered_users_board_path(@username, "Bespoke"))
    expect(page).to have_content("Bespoke")
    expect(page).to have_content("100% authentic")
    expect(page).to have_content("private")
  end

  it "is unable to edit other user's boards by button" do
    user_2 = create(:registered_user)
    board_2 = create(:board)

    visit registered_users_board_path(user_2.pinspiration_credentials.first.username, board_2.name)

    expect(page).not_to have_content('Edit')
  end

  xit "is unable to edit other user's boards by url" do
    user_2 = create(:registered_user)
    board_2 = create(:board)

    visit registered_users_edit_board_path(user_2.pinspiration_credentials.first.username, board_2.name)

    expect(page).to have_content('404')
  end

  xit "is unable to save board without name" do
    visit registered_users_edit_board_path(@username, @board.name)

    within "form" do
      fill_in "board[name]", with: nil
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
    expect(page).to have_content("error, board cannot be saved without name")
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

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
    expect(page).to have_content("error, board cannot be saved without description")
  end

  xit "is unable to save board without category" do
    visit registered_users_edit_board_path(@username, @board.name)

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      click_on "Submit"
    end

    expect(current_path).to eq(registered_users_edit_board_path(@username, @board.name))
    expect(page).to have_content("board cannot be saved without category")
  end
end
