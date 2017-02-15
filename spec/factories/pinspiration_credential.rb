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
    password "password"
    phone_number "555-555-5555"
    image_url "https://i2.wp.com/remoran.com/wp/wp-content/uploads/placeholder.png"
    registered_user
  end
end
