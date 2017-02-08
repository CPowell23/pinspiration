FactoryGirl.define do
  factory :registered_user do
    status "online"
    
    after(:create) do |registered_user|
      create(:pinspiration_credential, registered_user: registered_user)
    end

  end
end
