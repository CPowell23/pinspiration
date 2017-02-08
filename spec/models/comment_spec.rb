require "rails_helper"

describe Comment do
  context "validations" do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:registered_user) }
    it { is_expected.to validate_presence_of(:pin) }
  end

  context "associations" do
    it { is_expected.to belong_to(:registered_user) }
    it { is_expected.to belong_to(:pin) }
    it { is_expected.to have_many(:likes) }
  end
end
