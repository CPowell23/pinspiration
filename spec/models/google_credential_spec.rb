require "rails_helper"

describe GoogleCredential do
  context "validations" do
    it { is_expected.to validate_presence_of(:google_uid) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:registered_user) }

    it { is_expected.to validate_uniqueness_of(:google_uid) }
  end

  context "associations" do
    it { is_expected.to belong_to(:registered_user) }
  end
end
