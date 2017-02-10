class Comment < ApplicationRecord
  validates :content, presence: true
  validates :registered_user, presence: true
  validates :pin, presence: true

  belongs_to :registered_user
  belongs_to :pin
  has_many :likes, as: :target

  scope :sort_by_most_recent, -> { order(created_at: :desc) }
end
