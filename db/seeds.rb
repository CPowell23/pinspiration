class Seed

  def initialize
    @categories = (%w(DIY Food Home Style Beauty Humor Travel Shopping Animals Architecture Art Cars Celebs Design Education Entertainment Gardens Geek Health History Holiday Illustrations Kids Outdoors Photography Quotes Science Sports Tattoos Tech Weddings))
  end

  def self.start
    seed = Seed.new
    seed.destroy
    seed.generate_categories
    seed.generate_admin
    seed.generate_registered_users
    seed.generate_sample_pinspiration_user
    seed.generate_likes
    seed.generate_follow_joins
    seed.print_example_users
  end

  def destroy
    Like.destroy_all
    Comment.destroy_all
    Pin.destroy_all
    Board.destroy_all
    Category.destroy_all
    GoogleCredential.destroy_all
    PinspirationCredential.destroy_all
    RegisteredUser.destroy_all
    Admin.destroy_all
  end

  def generate_admin
    @admin = Admin.create!(name: "Tom Clancy", username: "clancey007", email: "clancey007@example.com", password: "password")
    puts "Admin: #{@admin.name} created!"
  end

  def generate_sample_pinspiration_user
    @sample_pinspiration_user = RegisteredUser.create!(status: "online")
    @sample_pinspiration_user.pinspiration_credentials.create!(name: Faker::Name.name,
                                                              username: Faker::Internet.user_name,
                                                              email: Faker::Internet.email,
                                                              password: "password",
                                                              phone_number: Faker::PhoneNumber.phone_number,)
  end

  def generate_registered_users
    80.times do |i|
      user = RegisteredUser.create!(status: ["offline", "online"].sample)
      generate_pinspiration_credentials(user)
      generate_boards(user)
      puts "User #{i}: #{user.status} status created!"
    end
    80.times do |i|
      user = RegisteredUser.create!(status: ["offline", "online"].sample)
      generate_google_credentials(user)
      generate_boards(user)
      puts "User #{i}: #{user.status} status created!"
    end
  end

  def generate_pinspiration_credentials(user)
    pinspiration_credential = user.pinspiration_credentials.create!(
      name: Faker::Name.name,
      username: Faker::Internet.unique.user_name,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password,
      phone_number: Faker::PhoneNumber.phone_number,
      image_url: Faker::Placeholdit.image
      )
    puts "Pinspiration Credentials: #{pinspiration_credential.name} created!"
  end

  def generate_google_credentials(user)
    google_credential = user.google_credentials.create!(
      google_uid: Faker::Crypto.md5,
      name: Faker::Name.name,
      username: Faker::Internet.unique.user_name,
      phone_number: Faker::PhoneNumber.phone_number,
      image_url: Faker::Placeholdit.image
      )
    puts "Google Credentials: #{google_credential.name} created!"
  end

  def generate_categories
    @categories.each do |category|
      Category.create(name: category)
      puts "Category: #{category} created!"
    end
  end

  def generate_boards(user)
    5.times do |i|
      board = user.boards.create!(
        private: [true, false].sample,
        name: Faker::Hipster.words([*1...5].sample),
        description: Faker::Hipster.sentence,
        category: Category.all.sample
      )
      generate_pins(board)
      puts "Board #{i}: #{board.name} created!"
    end
  end

  def generate_pins(board)
    5.times do |i|
      pin = board.pins.create!(
        description: Faker::Hipster.sentence,
        image_url: Faker::Placeholdit.image,
        article_url: Faker::Internet.url
      )
      generate_comments(pin)
      puts "Pin #{i}: #{pin.description} created!"
    end
  end

  def generate_comments(pin)
    3.times do |i|
      comment = pin.comments.create!(
        content: Faker::Hipster.sentence,
        registered_user: RegisteredUser.all.sample
      )
      puts "Comment #{i}: #{comment.content} created!"
    end
  end

  def generate_likes
    @users = RegisteredUser.all.map { |user| user }
    50.times do |i|
      board_like = Like.create!(
        registered_user: @users.pop,
        target_type: "Board",
        target_id: Board.all.sample.id
      )
      pin_like = Like.create!(
        registered_user: @users.pop,
        target_type: "Pin",
        target_id: Pin.all.sample.id
      )
      comment_like = Like.create!(
        registered_user: @users.pop,
        target_type: "Comment",
        target_id: Comment.all.sample.id
      )
    end
  end

  def generate_follow_joins
    @users = RegisteredUser.all
    x = @users.count - 2
    x.times do |i|
      FollowJoin.create!(registered_user_id: @users[i].id,
                          follower_id: @users[i+1].id)
      FollowJoin.create!(registered_user_id: @users[i].id,
                          follower_id: @users[i+2].id)
    end
  end

  def print_example_users
    puts "Here is a sample admin, just for you, so you can log in right away. \n"
    puts "Sample admin: \n" +
    "  email: #{@admin.email} \n" +
    "  password: password"

    puts "\n"

    puts "Here is a sample registered_user (with pinspiration credentials), just for you, so you can log in right away. \n"
    puts "Sample registered_user with pinspiration credentials: \n" +
    "  email: #{@sample_pinspiration_user.pinspiration_credentials.first.email} \n" +
    "  password: password"
  end

end

Seed.start
