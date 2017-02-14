require 'rails_helper'

describe "API for comments" do
  before (:each) do
    create_list(:registered_user, 3)

    RegisteredUser.all.each do |user|
      board_1 = create(:board)
      board_2 = create(:board)
      user.boards << board_1
      user.boards << board_2
    end

    Board.all.each do |board|
      pins = create_list(:pin, 3)
      board.pins << pins
    end

    Pin.all.each do |pin|
      comments = create_list(:comment, 3)
      pin.comments << comments
    end
  end

  it "provides comments as JSON for pin" do
    # stub_logged_in_api_user

    pin = Pin.first

    get "/api/v1/comments/#{pin.id}"

    comments = JSON.parse(response.body)
    comment = comments.first

    expect(comments.count).to eq(3)
    expect(comment).to have_key("content")
    expect(comment["pin_id"]).to eq(pin.id)
  end

  xit "accepts user with valid credentials" do

  end

  xit "rejects user with invalid credentials" do

  end
end
