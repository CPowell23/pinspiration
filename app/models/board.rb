class Board < ApplicationRecord
  validates :private, inclusion: { in: [ true, false ] }
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true
  validates :registered_user, presence: true
  validates :category, presence: true

  belongs_to :category
  belongs_to :registered_user
  has_many :pins
  has_many :likes, as: :target

  def privacy
    return 'public' if self[:private] == false
    return 'private' if self[:private] == true
  end
end
