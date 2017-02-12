class AddImageUrlToGoogleCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column :google_credentials, :image_url, :text
  end
end
