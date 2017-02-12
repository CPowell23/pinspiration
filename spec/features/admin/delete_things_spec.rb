require "rails_helper"

  describe "Logged in Admin" do
    before do
      user = create(:registered_user)
      @username = user.username
      @board_1, @board_2 = create_list(:board, 2, registered_user: user)

      @admin = create(:admin)
      stub_log_in_admin(@admin)
    end

    context "can delete boards" do
      it "from the board index page" do
        visit registered_users_boards_path(@username)

        within ".board:nth-of-type(1)" do
          expect(page).to have_selector(:link_or_button, "Delete")
        end
        within ".board:nth-of-type(2)" do
          expect(page).to have_selector(:link_or_button, "Delete")
        end

        within ".board:nth-of-type(1)" do
          click_on "Delete"
        end

        expect(Board.count).to eql(1)
        expect(page).to have_content("Successfully deleted board")
      end

      it "from the board show page" do
        visit registered_users_board_path(@username, @board_1.name)

        within ".board" do
          click_on "Delete"
        end

        expect(Board.count).to eql(1)
        expect(page).to have_content("Successfully deleted board")
      end
    end

    context "can delete pins" do
      before do
        @pin_1 = create(:pin, board: @board_1)
        create(:pin, board: @board_2)
      end

      it "from the pin index page" do
        visit registered_users_pins_path(@username)

        within ".pin:nth-of-type(1)" do
          expect(page).to have_selector(:link_or_button, "Delete")
        end
        within ".pin:nth-of-type(2)" do
          expect(page).to have_selector(:link_or_button, "Delete")
        end

        within ".pin:nth-of-type(1)" do
          click_on "Delete"
        end

        expect(Pin.count).to eql(1)
        expect(page).to have_content("Successfully deleted pin")
      end

      it "from the pin show page" do
        visit pin_path(@pin_1)

        within ".pin" do
          click_on "Delete"
        end

        expect(Pin.count).to eql(1)
        expect(page).to have_content("Successfully deleted pin")
      end
    end

    it "can delete comments" do
      pin = create(:pin, board: @board_1)
      comment = create(:comment, pin: pin)

      visit new_pin_comment_path(pin)
      within ".comment" do
        click_on "Delete"
      end

      expect(Comment.count).to eql(0)
    end
  end
