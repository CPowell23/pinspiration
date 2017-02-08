class GoogleCredential < ApplicationRecord
  validates :google_uid, presence: true
  validates :name, presence: true
  validates :username, presence: true
  validates :phone_number, presence: true
  validates :registered_user, presence: true

  validates_uniqueness_of :google_uid

  belongs_to :registered_user
end
