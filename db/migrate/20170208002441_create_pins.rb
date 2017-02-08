class CreatePins < ActiveRecord::Migration[5.0]
  def change
    create_table :pins do |t|
      t.text :description
      t.text :image_url
      t.text :article_url
      t.references :board
    end
  end
end
