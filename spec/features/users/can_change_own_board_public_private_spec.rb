require "rails_helper"

describe "As a user" do
  before do
    user = create(:user)
    stub_log_in_user(user)
    visit user_path
  end

  context "when I am logged in" do
    xit "I can edit the public/private status of a board" do
      # click on account icon
      # to see profile page
      # can select boar
      # am redirected to board's show page
      # click on edit icon
      # see a form to change board's information
      # can choose to change the board to public/private
      # click on "Save"
      # am taken to board's updated page
    end
  end

  context "other user's boards" do
    xit "I am not allowed to change board to private" do
      user_2 = create(:user)
      board = create(:board)
      user_2.boards << board

      # can select board
      # am redirected to board's show page

      expect(current_path).to be(board_path(user_2, board))
      expect(page).not_to have_content('edit')

      # I do not see an edit icon
    end

    xit "user sees error when they try to visit board edit url" do
      # get '/'
      # expect(page).to have_content('error')
    end
  end
end
