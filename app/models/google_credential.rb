class GoogleCredential < ApplicationRecord
  validates :google_uid, presence: true
  validates :name, presence: true
  validates :username, presence: true
  validates :registered_user, presence: true

  validates_uniqueness_of :google_uid

  belongs_to :registered_user

  def self.from_omniauth(auth_info)
    credential = GoogleCredential.find_by(google_uid: auth_info.info.google_uid)
      if credential
        credential
      else
        registered_user = RegisteredUser.create(status: 1)
        credential = registered_user.google_credentials.create(google_uid: auth_info.info.google_uid, 
                                                  name: auth_info.info.name, 
                                                  username: auth_info.info.name.parameterize)
        credential
      end
  end

end
