class CreateFollowJoins < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_joins do |t|
      t.references  :registered_user
      t.integer     :follower_id

      t.timestamps
    end
  end
end
