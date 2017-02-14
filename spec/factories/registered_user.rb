FactoryGirl.define do
  factory :registered_user do
    status 1
    
    after(:create) do |registered_user|
      create(:pinspiration_credential, registered_user: registered_user)
    end

  end
end
