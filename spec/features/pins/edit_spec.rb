require "rails_helper"

describe "Pin Edit" do
  before do
    user = create(:registered_user)
    stub_log_in_user(user)
    board = create(:board, registered_user: user)
    @pin = create(:pin, board: board)
  end

  it "logged in user can edit pin" do
    visit edit_pin_path(@pin)
    within "form" do
      fill_in "pin[description]", with: "This is the new description."
      fill_in "pin[image_url]", with: "http://i142.photobucket.com/albums/r96/thisdayinmusic/spice-girls.jpg"
      fill_in "pin[article_url]", with: "http://www.thisdayinmusic.com/pages/spice_girls"
      find("option[value='1']").select_option
      click_on "Submit"
    end

    expect(current_path).to eql(pin_path(@pin))
    expect(page).to have_content("Successfully edited pin")
    expect(page).to have_content("This is the new description")
    expect(page).to have_css("img[src*='http://i142.photobucket.com/albums/r96/thisdayinmusic/spice-girls.jpg']")

    # Add these tests once we have user controller
    # expect(page).to have_selector(:link_or_button, @pin.board.name)
    # expect(page).to have_selector(:css, "a[href='#{@pin.article_url}']")
  end
end
