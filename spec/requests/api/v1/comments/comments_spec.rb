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

  it "accepts user with valid credentials" do
    user = create(:registered_user)
    user.developer_credentials.create()
    api_key = user.developer_credentials.first.api_key

    pin = Pin.first

    get "/api/v1/pins/#{pin.id}/comments?api_key=#{api_key}"

    expect(response).to be_success
  end

  it "rejects user with invalid credentials" do
    pin = Pin.first
    comment = Comment.first
    get "/api/v1/pins/#{pin.id}/comments?api_key=12345678910"
    request_response = JSON.parse(response.body)

    expect(request_response["errors"]).to eq('Invalid key')
  end
  # 
  # xit "never returns private content" do
  #   board = create(:board, private: true)
  #   pin = board.pins.first
  #   pin.comments.create(:comment)
  #
  #   comment = pin.comment.first
  #
  #   expect(response).not_to be(success)
  # end

  it "provides read access for pin comments" do
    user = create(:registered_user)
    user.developer_credentials.create()
    api_key = user.developer_credentials.first.api_key

    pin = Pin.first

    get "/api/v1/pins/#{pin.id}/comments?api_key=#{api_key}"

    comments = JSON.parse(response.body)
    comment = comments.first

    expect(response).to be_success
    expect(comments.count).to eq(3)
    expect(comment).to have_key("content")
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end

  it "provides read access for one pin comment" do
    user = create(:registered_user)
    user.developer_credentials.create()
    api_key = user.developer_credentials.first.api_key
    pin = Pin.first
    comment = pin.comments.first

    get "/api/v1/pins/#{pin.id}/comments/#{comment.id}?api_key=#{api_key}"

    comment = JSON.parse(response.body)
    expect(comment).to have_key("content")
    expect(comment).to have_key("pin_id")
    expect(comment["pin_id"].to_i).to eq(pin.id)
    expect(comment).to have_key("registered_user_id")
  end

  it "provides create access for pin comments" do
    user = create(:registered_user)
    user.developer_credentials.create()
    api_key = user.developer_credentials.first.api_key

    pin = Pin.second
    comment = create(:comment)
    url = "api/v1/pins/#{pin.id}"
    body = { content: "some content", registered_user_id: "#{user.id}" }

    post "/api/v1/pins/#{pin.id}/comments?api_key=#{api_key}", params: body

    get "/api/v1/pins/#{pin.id}/comments?api_key=#{api_key}"

    comments = JSON.parse(response.body)

    expect(comments.count).to eq(4)
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end

  it "provides edit access for pin comments" do
    user = create(:registered_user)
    user.developer_credentials.create()
    api_key = user.developer_credentials.first.api_key

    pin = Pin.second
    comment = pin.comments.first
    body = { content: "some edited content"}

    put "/api/v1/pins/#{pin.id}/comments/#{comment.id}?api_key=#{api_key}", params: body

    get "/api/v1/pins/#{pin.id}/comments?api_key=#{api_key}"

    comments = JSON.parse(response.body)

    expect(comments.count).to eq(3)
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end

  it "provides delete access for pin comments" do
    user = create(:registered_user)
    user.developer_credentials.create()
    api_key = user.developer_credentials.first.api_key

    pin = Pin.first
    comment = pin.comments.first

    delete "/api/v1/pins/#{pin.id}/comments/#{comment.id}?api_key=#{api_key}"

    get "/api/v1/pins/#{pin.id}/comments?api_key=#{api_key}"

    comments = JSON.parse(response.body)

    expect(comments.count).to eq(2)
    expect(comments).not_to include(comment.id)
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end
end
