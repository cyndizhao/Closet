class AddXYToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :x, :integer
    add_column :items, :y, :integer
  end
end
