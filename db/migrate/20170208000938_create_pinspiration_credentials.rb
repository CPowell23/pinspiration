class CreatePinspirationCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :pinspiration_credentials do |t|
      t.string :name
      t.string :username
      t.string :email
      t.text :password_digest
      t.string :phone_number
      t.references :registered_user
    end
    add_index :pinspiration_credentials, :username, unique: true
    add_index :pinspiration_credentials, :email, unique: true
  end
end
