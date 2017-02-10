class AddTimestampsToEverything < ActiveRecord::Migration[5.0]
  def change
    add_column(:admins, :created_at, :datetime)
    add_column(:admins, :updated_at, :datetime)

    add_column(:boards, :created_at, :datetime)
    add_column(:boards, :updated_at, :datetime)

    add_column(:categories, :created_at, :datetime)
    add_column(:categories, :updated_at, :datetime)

    add_column(:comments, :created_at, :datetime)
    add_column(:comments, :updated_at, :datetime)

    add_column(:google_credentials, :created_at, :datetime)
    add_column(:google_credentials, :updated_at, :datetime)

    add_column(:likes, :created_at, :datetime)
    add_column(:likes, :updated_at, :datetime)

    add_column(:pins, :created_at, :datetime)
    add_column(:pins, :updated_at, :datetime)
    
    add_column(:pinspiration_credentials, :created_at, :datetime)
    add_column(:pinspiration_credentials, :updated_at, :datetime)

    add_column(:registered_users, :created_at, :datetime)
    add_column(:registered_users, :updated_at, :datetime)
  end
end
