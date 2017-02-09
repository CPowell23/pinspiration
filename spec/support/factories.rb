FactoryGirl.define do

  factory :admin do
    name "Example Admin"
    username "ExampleAdmin3000"
    email "admin@example.com"
    password "boom"
  end

  factory :pin do
    description Faker::Hipster.sentence
    image_url "https://s-media-cache-ak0.pinimg.com/564x/90/5d/a9/905da92511ef7e18b65e5c62cf1db38c.jpg"
    article_url "http://www.ravelry.com/patterns/library/black-roxy"
    board
  end

  factory :board do
    name Faker::Hipster.word
    description Faker::Hipster.sentence
    private false
    category
    registered_user
  end

  factory :category do
    sequence :name do |n|
      "#{n} Category"
    end
  end

  factory :registered_user do
    status "online"

    after(:create) do |registered_user|
      create(:pinspiration_credential, registered_user: registered_user)
    end
  end

  factory :pinspiration_credential do
    sequence :name do |n|
      "#{n} Name"
    end
    sequence :username do |n|
      "#{n}username"
    end
    sequence :email do |n|
      "#{n}@fake.com"
    end
    password "pasword"
    phone_number "555-555-5555"
    registered_user
  end

  factory :comment do
    content Faker::Hipster.sentence
    registered_user
    pin
  end

end
