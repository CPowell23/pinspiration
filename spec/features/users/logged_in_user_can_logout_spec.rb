require 'rails_helper'

describe "Logged in user workflow" do
  context "as a logged in user" do
    scenario "I can login with pinspiration credentials and then logout" do
      @user = create(:registered_user)
      stub_log_in_user(@user)
      visit root_path

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_content("Account Profile")
      expect(page).to have_content(@user.name)

      click_on("Log out")

      expect(current_path).to eq(login_path)
    end

    scenario "I can login with google credentials and then logout" do
      visit root_path
      stub_omniauth
      click_on("Google Sign In")

      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_content("Account Profile")

      click_on("Log out")

      expect(current_path).to eq(login_path)
    end

    def stub_omniauth
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
          {
            provider: "google_oauth2",
            uid: "107777756181491428139",
            info: {
              google_uid: "17635244972",
              name: "Severus Snape",
              email: "profsnape@hogwarts.edu",
              locale: "wizard world",
              gender: "male",
              given_name: "Severus",
              token: "ya29.GlvtA-mnI6g3bwmjaGpZaYyKo5GhMkm8yNaGjL1NmjO5LgPv1dprnLdxMIFnBZTFqyMivfbLoyz3ipcdShXK5n68GqIIL5feWayPJFs11zcQrWCgaJDgVMqfPdu-"
            }
          }
        )
    end
  end
end
