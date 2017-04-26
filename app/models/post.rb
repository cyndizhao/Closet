class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_attached_file :picture, styles: { medium: "500x500>"}, default_url: "/images/missing-image.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :category_id, presence: true
  validates :picture, presence: true
end
