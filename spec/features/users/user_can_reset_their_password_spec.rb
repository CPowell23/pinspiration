require 'rails_helper'

describe "Registed user who is not yet logged in" do
  # before(:each) do
  #   stub_const("Twilio::REST::Client", FakeSMS)
  # end

  context "a registered user" do
    scenario "I can send a sms to reset my password" do
      @registered_user = RegisteredUser.create!(status: 1)
      @credential      = PinspirationCredential.create!(name: "Jane",
                                                        username: "jane97",
                                                        email: "jane97@gmail.com",
                                                        password: "1234",
                                                        phone_number: "720-709-1846",
                                                        registered_user_id: @registered_user.id)

      visit login_path
      click_link("Reset Password")

      expect(current_path).to eq(password_reset_path)

      expect(page).to have_content("Enter your e-mail address below")
      fill_in :email, with: @credential.email
      click_button("Send SMS")
      @registered_user.reload

      expect(current_path).to eq(password_reset_path)
      expect(page).to have_content("SMS sent!")
    end

  end
end
