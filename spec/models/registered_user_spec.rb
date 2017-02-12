require "rails_helper"

describe RegisteredUser do
  context "validations" do
    it { is_expected.to validate_presence_of(:status) }
  end

  context "associations" do
    it { is_expected.to have_many(:pinspiration_credentials) }
    it { is_expected.to have_many(:google_credentials) }
    it { is_expected.to have_many(:boards) }
    it { is_expected.to have_many(:pins) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:follower_joins) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:following_joins) }
    it { is_expected.to have_many(:followings) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:likes) }

  end
end
