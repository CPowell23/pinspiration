class CreateDeveloperCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :developer_credentials do |t|
      t.references :registered_user, foreign_key: true
      t.string :api_key
      t.string :project_name

      t.timestamps null: :false
    end
  end
end
