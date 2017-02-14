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

    # username = "The Rock"
    # password = "boom"
    # @developer = Developer.create(username: username, password: password)
  end

  xit "accepts user with valid credentials" do
    username = "The Rock"
    password = "boom"

    # send request

    expect(response).to be(success)
  end

  xit "rejects user with invalid credentials" do
    user = create(:registered_user)
    username = user.username
    password = user.password
    stub_log_in_user(user)

    # send request

    expect(response).not_to be(success)
  end

  it "provides read access for pin comments" do
    # stub_logged_in_api_user

    pin = Pin.first

    get "/api/v1/pins/#{pin.id}/comments"

    comments = JSON.parse(response.body)
    comment = comments.first

    expect(comments.count).to eq(3)
    expect(comment).to have_key("content")
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end

  it "provides read access for one pin comment" do
    # stub_logged_in_api_user

    pin = Pin.first
    comment = pin.comments.first

    get "/api/v1/pins/#{pin.id}/comments/#{comment.id}"

    comment = JSON.parse(response.body)

    expect(comment).to have_key("content")
    expect(comment).to have_key("pin_id")
    expect(comment["pin_id"].to_i).to eq(pin.id)
    expect(comment).to have_key("registered_user_id")
  end

  it "provides create access for pin comments" do
    # stub_logged_in_api_user

    pin = Pin.second
    comment = create(:comment)
    url = "/api/v1/pins/#{pin.id}/comments"
    body = JSON.generate(content: "some content", pin_id: "#{pin.id}")
    conn = Faraday.new(url)
    conn.post do |req|
      req.body = body
    end

    get "/api/v1/pins/#{pin.id}/comments"

    comments = JSON.parse(response.body)

    expect(comments.count).to eq(4)
    expect(comments).to have_content(comment.content)
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end

  xit "provides edit access for pin comments" do
    # stub_logged_in_api_user

    pin = Pin.third
    comment = pin.comments.first
    content = "This is a new comment."

    ##### need to pass some content here #####
    put "/api/v1/#{pin.id}/comments/#{comment.id}"

    get "/api/v1/pins/#{pin.id}/comments"

    comments = JSON.parse(response.body)

    expect(comments.count).to eq(4)
    expect(comments).to have_content(content)
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end

  it "provides delete access for pin comments" do
    # stub_logged_in_api_user

    pin = Pin.first
    comment = pin.comments.first

    delete "/api/v1/pins/#{pin.id}/comments/#{comment.id}"

    get "/api/v1/pins/#{pin.id}/comments"

    comments = JSON.parse(response.body)

    expect(comments.count).to eq(2)
    expect(comments).not_to include(comment.id)
    comments.each do |comment|
      expect(comment["pin_id"]).to eq(pin.id)
    end
  end
end
