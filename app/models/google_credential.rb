class GoogleCredential < ApplicationRecord
  validates :google_uid, presence: true
  validates :name, presence: true
  # validates :username, presence: true
  # validates :phone_number, presence: true
  validates :registered_user, presence: true

  validates_uniqueness_of :google_uid

  belongs_to :registered_user

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end
end
