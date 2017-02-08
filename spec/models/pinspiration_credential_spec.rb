require "rails_helper"

describe PinspirationCredential do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:registered_user) }

    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_uniqueness_of(:registered_user_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:registered_user) }
  end
end
