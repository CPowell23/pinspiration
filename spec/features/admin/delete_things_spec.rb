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
      xit "from the board index page" do

      end

      xit "from the board show page" do

      end
    end

    context "can delete pins" do
      before do
        @pin_1 = create(:pin, board: @board_1)
        create(:pin, board: @board_2)
      end

      it "from the pin index page" do
        visit pins_index_path(@username)

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

    context "can delete comments" do
      
    end

    context "canNOT delete users" do

    end
  end
