require "rails_helper"

describe Board do
  context "validations" do
    it { is_expected.to validate_presence_of(:private) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:registered_user) }
    it { is_expected.to validate_presence_of(:category) }
  end

  context "associations" do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:registered_user) }
    it { is_expected.to have_many(:pins) }
    it { is_expected.to have_many(:likes) }
  end
end
