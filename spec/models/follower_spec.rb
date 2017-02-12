require "rails_helper"

describe Follower do
  context "validations" do
    it { is_expected.to validate_presence_of(:registered_user_id) }
    it { is_expected.to validate_presence_of(:follower_id) }

    it { is_expected.to validate_uniqueness_of(:registered_user_id).scoped_to(:follower_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:user_being_followed) }
    it { is_expected.to belong_to(:user_doing_the_following) }
  end
end
