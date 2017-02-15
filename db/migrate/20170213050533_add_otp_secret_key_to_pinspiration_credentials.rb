class AddOtpSecretKeyToPinspirationCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column :pinspiration_credentials, :otp_secret_key, :string
  end
end
