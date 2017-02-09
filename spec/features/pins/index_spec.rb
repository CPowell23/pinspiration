require "rails_helper"

describe "Pins Index" do
  before do
    # create a user
    @user_1 = create(:registered_user)
    @user_1_username = @user_1.pinspiration_credentials.first.username
    @user_2 = create(:registered_user)

    # create some boards for that user
    board_1, board_2 = create_list(:board, 2, registered_user: @user_1)
    board_3, board_4 = create_list(:board, 2, registered_user: @user_2)

    # create some pins for each board
    pin_1, pin_2 = create_list(:pin, 2, board: board_1)
    pin_3, pin_4 = create_list(:pin, 2, board: board_2)
    create_list(:pin, 2, board: board_3)
    create_list(:pin, 2, board: board_4)
    @user_1_pins = [pin_1, pin_2, pin_3, pin_4]
  end

  it "displays a user's pins" do
    visit pins_index_path(@user_1_username)

    expect(page).to have_css(".pin", count: 4)
    @user_1_pins.each do |pin|
      expect(page).to have_content(pin.description)
      expect(page).to have_css("img[src*='#{pin.image_url}']")

      # Add these tests once we have user controller
      # expect(page).to have_selector(:link_or_button, pin.board.name)
      # expect(page).to have_selector(:css, "a[href='#{pin.article_url}']")
    end
  end

end
