FactoryGirl.define do
  factory :board do
    name { Faker::Hipster.unique.words(2).join("") }
    description Faker::Hipster.sentence
    category
    registered_user
    private false
  end
end
