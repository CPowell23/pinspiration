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

  def registered_user_params
    params.require(:user).permit(:email, :password)
  end

  def name
    return pinspiration_credentials.first.name if pinspiration_credentials.count > 0
    google_credentials.first.name
  end

  def email
    return pinspiration_credentials.first.email if pinspiration_credentials.count > 0
    google_credentials.first.email
  end

  def phone_number
    return pinspiration_credentials.first.phone_number if pinspiration_credentials.count > 0
    google_credentials.first.phone_numer
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
