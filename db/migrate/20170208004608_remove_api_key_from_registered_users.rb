class RemoveApiKeyFromRegisteredUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :registered_users, :api_key, :text
  end
end
