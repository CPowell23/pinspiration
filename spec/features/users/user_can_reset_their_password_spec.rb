require 'rails_helper'

describe "Registed user who is not yet logged in" do
  # before(:each) do
  #   stub_const("Twilio::REST::Client", FakeSMS)
  # end

  context "a registered user" do
    scenario "I can send a sms to reset my password" do
      # @credential = create(:pinspiration_credential)
      @registered_user = RegisteredUser.create!(status: 1)
      @credential      = PinspirationCredential.create!(name: "Jane",
                                                        username: "jane97",
                                                        email: "jane97@gmail.com",
                                                        password: "1234",
                                                        phone_number: "303-883-4351",
                                                        registered_user_id: @registered_user.id)

      visit login_path
      click_link("Forgot your password?")

      expect(current_path).to eq(password_reset_path)

      expect(page).to have_content("Enter your e-mail address below")
      fill_in :email, with: @credential.email
      click_button("Send SMS")

      expect(current_path).to eq(password_reset_path)
      expect(page).to have_content("SMS sent!")
    end

  end
end

# class FakeSMS
#   Message = Struct.new(:from, :to, :body)
#
#   cattr_accessor :messages
#   self.messages = []
#
#   def initialize(_account_sid, _auth_token)
#   end
#
#   def messages
#     self
#   end
#
#   def create(from:, to:, body:)
#     self.class.messages << Message.new(from: from, to: to, body: body)
#   end
# end
