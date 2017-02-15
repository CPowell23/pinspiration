class DeveloperCredential < ApplicationRecord
  before_create :generate_api_key

  belongs_to :registered_user

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
  end
end
