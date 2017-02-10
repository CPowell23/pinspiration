FactoryGirl.define do
  factory :category do
    sequence :name do |n|
      "#{n} Category"
    end
  end
end
