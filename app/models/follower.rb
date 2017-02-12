class Follower < ApplicationRecord
  validates :registered_user_id, presence: true
  validates :follower_id, presence: true

  # Users should only be able to follow another user once
  validates_uniqueness_of :registered_user_id, {scope: :follower_id}

  belongs_to :user_being_followed, class_name: "RegisteredUser", foreign_key: :registered_user_id
  belongs_to :user_doing_the_following, class_name: "RegisteredUser", foreign_key: :follower_id
end
