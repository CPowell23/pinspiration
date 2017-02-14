require 'rails_helper'

describe "Guest login workflow" do
  context "An unregisted guest" do
   scenario "can visit the app home page" do
      visit login_path

      expect(current_path).to eq('/login')
      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_button("Continue")
      expect(page).to have_button("Google Sign In")
    end

   scenario "can create a new registration for the app using pinspiration credentials" do
      visit login_path
      click_on "Register"

      fill_in "pinspiration_credential[name]", with: "Jane Doe"
      fill_in "pinspiration_credential[username]", with: "janey37"
      fill_in "pinspiration_credential[email]", with: "jane@janemail.com"
      fill_in "pinspiration_credential[password]", with: 'password01'
      fill_in "pinspiration_credential[password_confirmation]", with: 'password01'
      fill_in "pinspiration_credential[phone_number]", with: "123-456-7789"
      fill_in "pinspiration_credential[image_url]", with: "http://static.boredpanda.com/blog/wp-content/uuuploads/cute-baby-animals/cute-baby-animals-13.jpg"
      click_button("Continue")

      expect(current_path).to eq(root_path)
    end

    scenario "can create a new registration for the app using google credentials" do
       visit login_path
      stub_omniauth
      click_on("Google Sign In")

      expect(page.status_code).to eq(200)
      expect(page).to have_content("Thank you for registering through google. Enjoy Pinspiration!")
      expect(current_path).to eq(root_path)
    end

    scenario "cannot create a new registration for the app with blank credentials" do
      visit login_path
      click_on "Register"
      click_button("Continue")

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Username can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Phone number can't be blank")
    end

    scenario "cannot create a new registration if the password and password confirmation do not match" do
      visit login_path
      click_on "Register"
      fill_in "pinspiration_credential[name]", with: "Jane Doe"
      fill_in "pinspiration_credential[username]", with: "janey37"
      fill_in "pinspiration_credential[email]", with: "jane@janemail.com"
      fill_in "pinspiration_credential[password]", with: 'password01'
      fill_in "pinspiration_credential[password_confirmation]", with: 'password02'
      fill_in "pinspiration_credential[phone_number]", with: "123-456-7789"
      click_button("Continue")

      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "can log in" do
      user = create(:registered_user)
      email = user.pinspiration_credentials.first.email

      visit login_path
      fill_in "email", with: "#{email}"
      fill_in "password", with: "password"
      click_on "Continue"

      expect(current_path).to eql(root_path)
      expect(page).to have_content("Successfully logged in")
    end

    scenario "cannot log in if they enter invalid credentials" do
      user = create(:registered_user)
      email = user.pinspiration_credentials.first.email

      visit login_path
      fill_in "email", with: "#{email}"
      fill_in "password", with: "wrong"
      click_on "Continue"

      expect(current_path).to eql(login_path)
      expect(page).to have_content("Email and password combination does not exist")
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
