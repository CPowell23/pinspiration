class RegisteredUser < ApplicationRecord
  validates :status, presence: true

  has_many :pinspiration_credentials
  has_many :google_credentials
  has_many :boards
  has_many :pins, through: :boards
  has_many :comments
  has_many :likes

  enum status: [:offline, :online]

  def username
    return pinspiration_credentials.first.username if pinspiration_credentials.count > 0
    google_credentials.first.username
  end

  def already_liked?(target)
    return false if likes.count == 0
    targets = likes.pluck(:target_id, :target_type)
    liked = targets.map do |id, type|
      target.id == id && target.class.to_s == type
    end
    liked.include?(true)
  end
end
