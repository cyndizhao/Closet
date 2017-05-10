class AddAttachmentSelfieToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :selfie
    end
  end

  def self.down
    remove_attachment :users, :selfie
  end
end
