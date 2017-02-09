class Pin < ApplicationRecord
  validates :description, presence: true
  validates :image_url, presence: true
  validates :article_url, presence: true
  validates :board, presence: true

  belongs_to :board
  has_one :registered_user, through: :board
  has_many :likes, as: :target
  has_many :comments, dependent: :destroy
end
