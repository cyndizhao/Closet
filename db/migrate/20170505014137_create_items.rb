class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :price
      t.string :link
      t.references :post, foreign_key: true
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end
