require "rails_helper"

describe "Board Create Errors" do
  before do
    @user = create(:registered_user)
    stub_log_in_user(@user)
    category = create(:category)
  end

  it "cannot create a board without a name" do
    visit new_registered_users_board_path(@user.username)

    within "form" do
      fill_in "board[name]", with: nil
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(page).to have_content('Add a New Board')
    expect(page).to have_content("Name can't be blank")
  end

  it "cannot create a board without a description" do
    visit new_registered_users_board_path(@user.username)

    within "form" do
      fill_in "board[name]", with: "100% Authentic"
      fill_in "board[description]", with: nil
      find("option[value='private']").select_option
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(page).to have_content('Add a New Board')
    expect(page).to have_content("Description can't be blank")
  end

  it "cannot create a board without a category" do
    visit new_registered_users_board_path(@user.username)

    within "form" do
      fill_in "board[name]", with: "Bespoke"
      fill_in "board[description]", with: "100% authentic"
      find("option[value='private']").select_option
      click_on "Submit"
    end

    expect(page).to have_content('Add a New Board')
    expect(page).to have_content("Category can't be blank")
  end
end
