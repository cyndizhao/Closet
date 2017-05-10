class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :gender
  has_many :items, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_attached_file :picture, styles: { medium: "400x400>"}, default_url: "/images/missing-image.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :category_id, presence: true
  validates :gender_id, presence: true
  validates :picture, presence: true

  def like_for(user)
    likes.find_by(user: user)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end
end
