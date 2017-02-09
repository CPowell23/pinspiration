class RegisteredUser < ApplicationRecord
  validates :status, presence: true

  has_many :pinspiration_credentials
  has_many :google_credentials
  has_many :boards

  enum status: [:offline, :online]

end
