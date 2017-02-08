FactoryGirl.define do
  factory :comment do
    content Faker::Hipster.sentence
    registered_user
    pin
  end
end
