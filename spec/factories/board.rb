FactoryGirl.define do
  factory :board do
    name { Faker::Hipster.word }
    description Faker::Hipster.sentence
    category
    registered_user
    private false
  end
end
