class Seed

  def initialize
    @categories = (%w(DIY Food Home Style Beauty Humor Travel Shopping Animals Architecture Art Cars Celebs Design Education Entertainment Gardens Geek Health History Holiday Illustrations Kids Outdoors Photography Quotes Science Sports Tattoos Tech Weddings))
    @pin_images = ["http://static.boredpanda.com/blog/wp-content/uuuploads/cute-baby-animals-2/cute-baby-animals-2-2.jpg",
                    "http://static.boredpanda.com/blog/wp-content/uuuploads/cute-baby-animals/cute-baby-animals-13.jpg",
                    "https://i.ytimg.com/vi/1LqyOX12_nQ/maxresdefault.jpg",
                    "http://imgs.abduzeedo.com/files/articles/baby-animals/Baby-Animals-011.jpg",
                    "https://pbs.twimg.com/profile_images/618186189917413376/WMkxLMMG.jpg",
                    "http://www.godvine.com/pics/Baby-Animals/Baby%20Seal.jpg",
                    "http://static.boredpanda.com/blog/wp-content/uuuploads/cute-baby-animals/cute-baby-animals-2.jpg",
                    "http://www.funcage.com/blog/wp-content/uploads/2011/01/FunCage-cute-baby-animal-1-480x320.jpg",
                    "http://www.funcage.com/blog/wp-content/uploads/2011/01/FunCage-cute-baby-animal-7.jpg",
                    "https://i.ytimg.com/vi/QpnmL96l0mA/maxresdefault.jpg",
                    "http://dailynewsdig.com/wp-content/uploads/2013/05/Cutest-Baby-Animals-top-10-5.jpg",
                    "http://static.boredpanda.com/blog/wp-content/uploads/2014/12/cutest-baby-animals-24__605.jpg",
                    "https://img.buzzfeed.com/buzzfeed-static/static/2015-12/21/10/campaign_images/webdr14/a-definitive-ranking-of-the-cutest-baby-animals-2-27983-1450711830-8_dblbig.jpg",
                    "http://a57.foxnews.com/images.foxnews.com/content/fox-news/science/slideshow/2014/04/10/cuddly-critters-cutest-baby-animals/_jcr_content/slideshow-par/slide_image0/image.img.jpg/0/549/1422687145031.jpg?ve=1&tl=1?ve=1",
                    "https://img.buzzfeed.com/buzzfeed-static/static/2014-01/enhanced/webdr06/8/22/enhanced-buzz-30136-1389237295-0.jpg",
                    "http://www.window-blinds-project.com/image-files/patio-ideas-5.jpg",
                    "http://www.eclipseawning.com/wp-content/uploads/natural-patio-design.jpg",
                    "http://patiodesignpictures.com/image/20/Backyard-Patios-Pictures-1.jpg",
                    "http://hgtvhome.sndimg.com/content/dam/images/hgtv/fullset/2011/4/26/0/RMS-Trudie_deck-umbrella-upholstery-garden-outdoor_s4x3.jpg.rend.hgtvcom.966.725.jpeg",
                    "http://hgtvhome.sndimg.com/content/dam/images/hgrm/fullset/2011/6/29/6/DesignLens_seaside-patio_s4x3.jpg.rend.hgtvcom.616.462.jpeg",
                    "http://charlotte.archadeck.com/images/gallery/23/library/125.jpg",
                    "http://ab.pbimgs.com/pbimgs/ab/images/dp/wcm/201640/0015/holman-shelves-o.jpg",
                    "http://rk.pbimgs.com/pbimgs/rk/images/dp/wcm/201640/0009/savannah-ikat-print-pillow-cover-c.jpg",
                    "https://s-media-cache-ak0.pinimg.com/736x/78/82/b4/7882b4e8ec5d4a23ce0bf78848e4bd39.jpg",
                    "http://blog.potterybarn.com/wp-content/uploads/2013/06/fall-preview-image.jpg",
                    "https://s-media-cache-ak0.pinimg.com/736x/96/bf/0d/96bf0dcea0f4e6236bb0058dc7cd6d62.jpg",
                    "https://s-media-cache-ak0.pinimg.com/originals/9e/3e/ad/9e3ead7f38beaa126dfc400d8b877ffe.jpg"]
    @user_images = ["https://avatars1.githubusercontent.com/u/16562801?v=3&s=400",
                    "https://avatars1.githubusercontent.com/u/18703294?v=3&s=400",
                    "https://avatars1.githubusercontent.com/u/8581642?v=3&s=400",
                    "https://media.licdn.com/mpr/mpr/shrinknp_400_400/p/1/005/072/08c/00a7572.jpg",
                    "https://avatars1.githubusercontent.com/u/15188446?v=3&s=460"]
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
    @sample_pinspiration_user.pinspiration_credentials.create!(name: "Martha Stewart",
                                                              username: "marthastewart",
                                                              email: "martha@marthastewart.com",
                                                              password: "password",
                                                              image_url: "https://assets.entrepreneur.com/content/16x9/822/4-secrets-lifelong-success-martha-stewart.jpg",
                                                              phone_number: Faker::PhoneNumber.phone_number,)
  end

  def generate_registered_users
    20.times do |i|
      user = RegisteredUser.create!(status: ["offline", "online"].sample)
      generate_pinspiration_credentials(user)
      generate_boards(user)
      puts "User #{i}: #{user.status} status created!"
    end
    20.times do |i|
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
      image_url: @user_images.sample
      )
    puts "Pinspiration Credentials: #{pinspiration_credential.name} created!"
  end

  def generate_google_credentials(user)
    google_credential = user.google_credentials.create!(
      google_uid: Faker::Crypto.md5,
      name: Faker::Name.name,
      username: Faker::Internet.unique.user_name,
      phone_number: Faker::PhoneNumber.phone_number,
      image_url: @user_images.sample
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
        name: Faker::Hipster.unique.words.join(" "),
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
        image_url: @pin_images.sample,
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
    5.times do |i|
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
