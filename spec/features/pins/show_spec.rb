require "rails_helper"

describe "Pin Show" do
  before do
    @pin = create(:pin)
  end

  it "displays one pin" do
    visit pin_path(@pin)

    expect(page).to have_content(@pin.description)
    expect(page).to have_css("img[src*='#{@pin.image_url}']")

    # Add these tests once we have user controller
    # expect(page).to have_selector(:link_or_button, @pin.board.name)
    # expect(page).to have_selector(:css, "a[href='#{@pin.article_url}']")
end
end
