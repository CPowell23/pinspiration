require "rails_helper"

describe "Pin Create" do
  context "logged in user" do
    before do
      user = create(:registered_user)
      stub_log_in_user(user)
      create_list(:board, 2, registered_user: user)
    end

    it "can create pins" do
      visit new_pin_path
      within "form" do
        fill_in "pin[description]", with: "This is the description."
        fill_in "pin[image_url]", with: "http://i142.photobucket.com/albums/r96/thisdayinmusic/spice-girls.jpg"
        fill_in "pin[article_url]", with: "http://www.thisdayinmusic.com/pages/spice_girls"
        find("option[value='1']").select_option
        click_on "Submit"
      end
      pin = Pin.last

      expect(current_path).to eql(pin_path(pin))
      expect(page).to have_content("Successfully created pin")
      expect(page).to have_content(pin.description)
      expect(page).to have_css("img[src*='#{pin.image_url}']")

      # Add these tests once we have user controller
      # expect(page).to have_selector(:link_or_button, pin.board.name)
      # expect(page).to have_selector(:css, "a[href='#{pin.article_url}']")
    end

  end
end
