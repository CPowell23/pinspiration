require "rails_helper"

describe "Logged in Admin" do
  before do
    admin = create(:admin)
    stub_log_in_admin(admin)
    visit admin_dashboard_path
  end

  it "does not see a link to Log in" do
    expect(page).not_to have_selector(:link_or_button, "Log in")
  end

  it "sees a link to Log out" do
    expect(page).to have_selector(:link_or_button, "Log out")
  end

  context "after clicking Log out" do
    before do
      click_on "Log out"
    end

    it "is sent to the admin login page" do
      expect(current_path).to eql(admin_login_path)
    end

    it "no longer sees a link to Log out in the nav" do
      within "nav" do
        expect(page).not_to have_selector(:link_or_button, "Log out")
      end
    end
  end

end
