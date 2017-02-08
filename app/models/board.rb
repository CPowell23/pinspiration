class Board < ApplicationRecord
  validates :private, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :registered_user, presence: true
  validates :category, presence: true

  belongs_to :category
  belongs_to :registered_user
  has_many :pins
  has_many :likes, as: :target
end
