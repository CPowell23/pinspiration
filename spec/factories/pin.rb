FactoryGirl.define do
  factory :pin do
    description Faker::Hipster.sentence
    image_url "https://s-media-cache-ak0.pinimg.com/564x/90/5d/a9/905da92511ef7e18b65e5c62cf1db38c.jpg"
    article_url "http://www.ravelry.com/patterns/library/black-roxy"
    board
  end
end
