require "rails_helper"

describe Pin do
  context "validations" do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:image_url) }
    it { is_expected.to validate_presence_of(:article_url) }
    it { is_expected.to validate_presence_of(:board) }
  end

  context "associations" do
    it { is_expected.to belong_to(:board) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_one(:registered_user) }
  end
end
