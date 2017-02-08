class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :registered_user
      t.references :target, :polymorphic => true
    end
  end
end
