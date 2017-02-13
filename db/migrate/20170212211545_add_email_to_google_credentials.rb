class AddEmailToGoogleCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column(:google_credentials, :email, :string)
  end
end
