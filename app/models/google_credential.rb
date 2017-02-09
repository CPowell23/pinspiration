class GoogleCredential < ApplicationRecord
  validates :google_uid, presence: true
  validates :name, presence: true
  validates :username, presence: true
  validates :registered_user, presence: true

  validates_uniqueness_of :google_uid

  belongs_to :registered_user

  def self.from_omniauth(auth_info)
    where(google_uid: auth_info.uid).find_or_create do |credential|
      credential.name = auth_info.info.name
      credential.username = auth_info.info.name.parameterize
      # credential.token = auth_info.credentials.token
      credential.save
    end
  end

end
