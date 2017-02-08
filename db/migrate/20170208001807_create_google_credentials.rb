class CreateGoogleCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :google_credentials do |t|
      t.string :google_uid
      t.string :name
      t.string :username
      t.string :phone_number
      t.references :registered_user
    end
    add_index :google_credentials, :google_uid, unique: true
  end
end
