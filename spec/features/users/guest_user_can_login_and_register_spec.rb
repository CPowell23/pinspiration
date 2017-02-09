require 'rails_helper'

describe "Guest login workflow" do
  context "An unregisted guest" do
    xit "can visit the app home page" do
      visit root_path

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome to Pinspirations")
      expect(page).to have_button("Continue")
      # expect(page).to have_button("Continue with Google")
    end

    xit "can create a new registration for the app using pinspiration credentials" do
      visit root_path

      fill_in "Name", with: "Jane Doe"
      fill_in "Username", with: "janey37"
      fill_in "Email", with: "jane@janemail.com"
      fill_in "Password", with: 'password01'
      fill_in "Phone number", with: "123-456-7789"
      click_button("Continue")
      
      expect(current_path).to eq(root_path)
    end

    it "can create a new registration for the app using google credentials" do
      visit root_path
      click_on("Google SignIn")
      stub_oauth

      expect(page.status_code).to eq(200)
    end

    xit "cannot create a new registration for the app with invalid credentials" do
      visit root_path

       fill_in "Name", with: ""
      fill_in "Username", with: "janey37"
      fill_in "Email", with: "jane@janemail.com"
      fill_in "Password", with: 'password01'
      fill_in "Phone number", with: "123-456-7789"
      click_button("Continue")

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Missing needed credentials or passwords do not match!")
    end

    def stub_oauth
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
          {           
            provider: "google",
            uid: "107777756181491428139",
            info: {
              name: "Severus Snape", 
              email: "profsnape@hogwarts.edu",
              locale: "wizard world", 
              gender: "male", 
              given_name: "Severus", 
              token: "ya29.GlvtA2V-XVLXzt__yZh3ZO1SJh4wDauL6zeMkQcgsqeO-f3Xrpe-egfjfVNDPuJUtZ0D8czN8Jq8n33OdffqmK55SHvwrNLjikj-FcQOUHCAcUglTjeKtfDsjMlj"
            }
          }
        )
    end

  end
end
