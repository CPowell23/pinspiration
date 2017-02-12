require "rails_helper"

describe "Comment Create" do
  context "logged in user" do
    before do
      @user_1, @user_2 = create_list(:registered_user, 2)
      board = create(:board, registered_user: @user_2)
      @pin = create(:pin, board: board)
      stub_log_in_user(@user_1)
      visit pin_path(@pin)
    end

    it "can post a comment on another user's pin" do
      click_on "Show Comments"
      within "form" do
        fill_in "comment[content]", with: "This is the content of the comment."
        click_on "Comment"
      end

      expect(Comment.count).to eql(1)
      expect(current_path).to eql(new_pin_comment_path(@pin))
      expect(page).to have_content("This is the content of the comment.")
      expect(page).to have_content("Thank you for your comment!")
    end
  end
end
