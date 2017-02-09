class RegisteredUser < ApplicationRecord
  validates :status, presence: true

  has_many :pinspiration_credentials
  has_many :google_credentials
  has_many :boards

  enum status: [:offline, :online]

  def self.from_omniauth(auth_info)
    # find_or_create_by(google_credentials: auth_info.info.name)
    #   GoogleCredential.from_omniauth

  end
end
