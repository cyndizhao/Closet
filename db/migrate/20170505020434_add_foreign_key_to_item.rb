class AddForeignKeyToItem < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key "items", "brands"
  end
end
