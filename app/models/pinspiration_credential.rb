class PinspirationCredential < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :phone_number, presence: true
  validates :registered_user, presence: true

  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :registered_user_id

  belongs_to :registered_user
end
