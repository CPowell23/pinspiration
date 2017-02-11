FactoryGirl.define do
  factory :board do
    name { Faker::Hipster.word }
    description Faker::Hipster.sentence
    private false
    category
    registered_user
  end
end
