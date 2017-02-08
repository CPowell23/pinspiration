class RegisteredUser < ApplicationRecord
  validates :status, presence: true
  
  has_many :pinspiration_credentials
  has_many :google_credentials
  has_many :boards
  has_many :pins, through: :boards

  enum status: [:offline, :online]

  def username
    return pinspiration_credentials.first.username if pinspiration_credentials.count > 0
    google_credentials.first.username
  end

end
