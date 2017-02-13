class AddImageUrlToPinspirationCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column :pinspiration_credentials, :image_url, :text
  end
end
