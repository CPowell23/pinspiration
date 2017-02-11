require "rails_helper"

describe "Pin Create Sad Path" do
  context "logged in user enters invalid pin information" do
    before do
      user = create(:registered_user)
      stub_log_in_user(user)
      create_list(:board, 2, registered_user: user)
      visit new_pin_path
    end

    it "description cannot be blank" do
      within "form" do
        fill_in "pin[image_url]", with: "http://i142.photobucket.com/albums/r96/thisdayinmusic/spice-girls.jpg"
        fill_in "pin[article_url]", with: "http://www.thisdayinmusic.com/pages/spice_girls"
        find("option[value='1']").select_option
        click_on "Submit"
      end

      expect(page).to have_content("Description can't be blank")
    end

    it "image_url cannot be blank" do
      within "form" do
        fill_in "pin[description]", with: "This is the description."
        fill_in "pin[article_url]", with: "http://www.thisdayinmusic.com/pages/spice_girls"
        find("option[value='1']").select_option
        click_on "Submit"
      end

      expect(page).to have_content("Image url can't be blank")
    end

    it "article_url cannot be blank" do
      within "form" do
        fill_in "pin[description]", with: "This is the description."
        fill_in "pin[image_url]", with: "http://i142.photobucket.com/albums/r96/thisdayinmusic/spice-girls.jpg"
        find("option[value='1']").select_option
        click_on "Submit"
      end

      expect(page).to have_content("Article url can't be blank")
    end

    it "board must be selected" do
      within "form" do
        fill_in "pin[description]", with: "This is the description."
        fill_in "pin[image_url]", with: "http://i142.photobucket.com/albums/r96/thisdayinmusic/spice-girls.jpg"
        fill_in "pin[article_url]", with: "http://www.thisdayinmusic.com/pages/spice_girls"
        click_on "Submit"
      end

      expect(page).to have_content("Board can't be blank")
    end
  end
end
