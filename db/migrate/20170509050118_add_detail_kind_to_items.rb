class AddDetailKindToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :detail, :string
    add_column :items, :kind, :string
  end
end
