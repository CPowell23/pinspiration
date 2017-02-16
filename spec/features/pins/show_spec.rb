require "rails_helper"

describe "Pin Show" do
  before do
    @board = create(:board)
    @pin = Pin.create(description: "best ever pin",
                  image_url: "https://s-media-cache-ak0.pinimg.com/564x/90/5d/a9/905da92511ef7e18b65e5c62cf1db38c.jpg",
                  article_url: "http://www.ravelry.com/patterns/library/black-roxy",
                  board: @board)
  end

  it "displays one pin" do
    visit pin_path(@pin)

    expect(page).to have_content(@pin.description)
    expect(page).to have_css("img[src*='#{@pin.image_url}']")

    # expect(page).to have_selector(:link_or_button, @board.name)
    # expect(page).to have_content(:css, "a[href='#{@pin.article_url}']")
  end
end
