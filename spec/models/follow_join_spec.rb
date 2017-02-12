require "rails_helper"

describe FollowJoin do
  context "validations" do
    it { is_expected.to validate_presence_of(:registered_user_id) }
    it { is_expected.to validate_presence_of(:follower_id) }

    it { is_expected.to validate_uniqueness_of(:registered_user_id).scoped_to(:follower_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:following) }
  end
end
