require "rails_helper"

describe "Board Create" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    @username = @user.pinspiration_credentials.first.username
    @category = create(:category)
  end

  xit "a user can create a new board from the board show page with valid attributes" do
    visit registered_users_boards_path(@username)

    find('li.image').click

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Create"
    end

    expect(current_path).to eq(registered_users_board_path(@username, "Bespoke"))
    expect(page).to have_content("Bespoke")
    expect(page).to have_content("100% authentic")
    expect(page).to have_content("private")
  end

  it "a new board is public by default" do
    visit new_registered_users_board_path(@username)

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: "100% authentic"
      find("option[value='1']").select_option
      find("option[value='public']").select_option
      click_on "Create"
    end

    expect(current_path).to eq(registered_users_board_path(@username, "Bespoke"))
    expect(page).to have_content("Bespoke")
    expect(page).to have_content("100% authentic")
    expect(page).not_to have_content("private")
  end
end
