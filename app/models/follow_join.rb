class FollowJoin < ApplicationRecord
  validates :registered_user_id, presence: true
  validates :follower_id, presence: true

  # Users should only be able to follow another user once
  validates_uniqueness_of :registered_user_id, {scope: :follower_id}

  belongs_to :follower, class_name: "RegisteredUser", foreign_key: :follower_id
  belongs_to :following, class_name: "RegisteredUser", foreign_key: :registered_user_id
end
