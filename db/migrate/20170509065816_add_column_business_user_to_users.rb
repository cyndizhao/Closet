class AddColumnBusinessUserToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :business_user, :boolean
  end
end
