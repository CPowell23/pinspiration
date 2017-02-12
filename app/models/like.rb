class Like < ApplicationRecord
  validates :registered_user, presence: true
  validates :target, presence: true

  # Users should only be able to like something once
  validates_uniqueness_of :registered_user_id, {scope: :target_id}

  belongs_to :registered_user
  belongs_to :target, polymorphic: true

  def self.this_user(target, registered_user)
    Like.where(target: target, registered_user: registered_user).first
  end
end
