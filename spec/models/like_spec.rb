require "rails_helper"

describe Like do
  context "validations" do
    it { is_expected.to validate_presence_of(:registered_user) }
    it { is_expected.to validate_presence_of(:target) }

    it { is_expected.to validate_uniqueness_of(:registered_user_id).scoped_to(:target_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:registered_user) }
    it { is_expected.to belong_to(:target) }
  end
end
