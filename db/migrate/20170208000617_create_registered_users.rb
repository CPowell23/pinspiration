class CreateRegisteredUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :registered_users do |t|
      t.text :api_key
      t.integer :status
    end
    add_index :registered_users, :api_key, unique: true
  end
end
