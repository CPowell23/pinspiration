FactoryGirl.define do
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
end
