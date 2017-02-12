require "rails_helper"

describe "Comment Delete" do
  context "logged in user" do
    before do
      # create 2 users
      @user_1, @user_2, @user_3 = create_list(:registered_user, 3)

      # create a board for user 2
      board = create(:board, registered_user: @user_2)

      # create a pin on user 2's board
      @pin = create(:pin, board: board)

      # user 1 & user 3 comment on user 2's pin
      @comment_from_user_1 = create(:comment, pin: @pin, registered_user: @user_1, content: "User 1's comment.")
      @comment_from_user_3 = create(:comment, pin: @pin, registered_user: @user_3, content: "User 3's comment.")

      stub_log_in_user(@user_1)
      visit pin_path(@pin)
    end

    it "can can delete their comment" do
      click_on "Show Comments"
      within (".comment:nth-of-type(2)") do
        click_on "Delete"
      end

      expect(Comment.count).to eql(1)
      expect(@user_1.comments.count).to eql(0)
      expect(current_path).to eql(new_pin_comment_path(@pin))
      expect(page).to have_content("User 3's comment.")
      expect(page).not_to have_content("User 1's comment.")
      expect(page).to have_content("Your comment was deleted")
    end

    it "cannot delete another user's comment" do
      click_on "Show Comments"
      within (".comment:nth-of-type(1)") do
        expect(page).not_to have_selector(:link_or_button, "Delete")
      end
    end
  end
end
