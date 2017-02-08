require "rails_helper"

describe "When an admin" do
  before do
    visit admin_login_path
    @admin = create(:admin)
  end

  context "visits the admin login path" do
    it "they do not see a link to logout" do
      expect(page).not_to have_selector(:link_or_button, "Log out")
    end

    it "they see a form to enter their credentials" do
      expect(page).to have_css("form")
      within "form" do
        expect(page).to have_selector(:link_or_button, "Log in")
      end
    end
  end

  context "enters invalid login credentials" do
    it "they stay on the login page" do
      click_on "Log in"
      expect(current_path).to eql(admin_login_path)
    end

    context "they see an error message if" do
      it "email is blank" do
        fill_in "password", with: "boom"
        click_on "Log in"

        expect(page).to have_content("Email and password combination does not exist")
      end

      it "password is blank" do
        fill_in "email", with: @admin.email
        click_on "Log in"

        expect(page).to have_content("Email and password combination does not exist")
      end

      it "email / password combination does not exist" do
        fill_in "email", with: @admin.email
        fill_in "password", with: "abcd"
        click_on "Log in"

        expect(page).to have_content("Email and password combination does not exist")
      end
    end

  end

  context "enters valid login credentials" do
    before do
      fill_in "email", with: @admin.email
      fill_in "password", with: "boom"
      click_on "Log in"
    end

    it "they are redirected to the admin dashboard" do
      expect(current_path).to eql(admin_dashboard_path)
    end

    it "they see a message confirming successful login" do
      expect(page).to have_content("Successfully logged in")
    end
  end
end
