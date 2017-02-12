require 'rails_helper'

describe "Guest login workflow" do
  context "An unregisted guest" do
   scenario "can visit the app home page" do
      visit login_path

      expect(current_path).to eq('/login')
      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_button("Continue")
      expect(page).to have_link("Google SignIn")
    end

   scenario "can create a new registration for the app using pinspiration credentials" do
      visit login_path

      fill_in "Name", with: "Jane Doe"
      fill_in "Username", with: "janey37"
      fill_in "Email", with: "jane@janemail.com"
      fill_in "Password", with: 'password01'
      fill_in "Phone number", with: "123-456-7789"
      click_button("Continue")

      expect(current_path).to eq(root_path)
    end

    scenario "can create a new registration for the app using google credentials" do
      visit login_path
      stub_omniauth
      click_on("Google SignIn")

      expect(page.status_code).to eq(200)
      expect(page).to have_content("Thank you for registering through google. Enjoy Pinspiration!")
      expect(current_path).to eq(root_path)
    end

    scenario "cannot create a new registration for the app with invalid pinspiration credentials" do
      visit login_path

      fill_in "Username", with: "janey37"
      fill_in "Email", with: "jane@janemail.com"
      fill_in "Phone number", with: "123-456-7789"
      click_button("Continue")

      expect(current_path).to eq(login_path)
      expect(page).to have_content("User not saved. Please input information into each field and try again.")
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
