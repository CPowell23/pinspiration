class RegisteredUser < ApplicationRecord
  validates :status, presence: true

  has_one :pinspiration_credential
  has_one :google_credential
end
