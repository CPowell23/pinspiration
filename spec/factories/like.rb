FactoryGirl.define do 
  factory :pin_like, class: Like do
    registered_user
    association :target, factory: :pin
  end

  factory :board_like, class: Like do
    registered_user
    association :target, factory: :board
  end
end
