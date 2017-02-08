class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.boolean :private
      t.string :name
      t.text :description
      t.references :registered_user
      t.references :category
    end
  end
end
