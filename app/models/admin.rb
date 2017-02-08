class Admin < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  validates_uniqueness_of :email
  validates_uniqueness_of :username
end
