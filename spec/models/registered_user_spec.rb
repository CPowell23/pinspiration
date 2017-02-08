require "rails_helper"

describe RegisteredUser do
  context "validations" do
    it { is_expected.to validate_presence_of(:status) }
  end

  context "associations" do
    it { is_expected.to have_one(:pinspiration_credential) }
    it { is_expected.to have_one(:google_credential) }
  end
end
