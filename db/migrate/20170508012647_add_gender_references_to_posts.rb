class AddGenderReferencesToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :gender, foreign_key: true
  end
end
