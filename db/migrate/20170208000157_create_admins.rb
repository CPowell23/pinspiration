class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :username
      t.string :email
      t.text :password_digest
    end
    add_index :admins, :username, unique: true
    add_index :admins, :email, unique: true
  end
end
