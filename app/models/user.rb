class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # has_many :likes, dependent: :nullify
  has_attached_file :selfie, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :selfie, content_type: /\Aimage\/.*\z/

  has_many :followings # gives an array of "Following" objects where this user is this one being followed
  has_many :followers, through: :followings # takes the `followings` takes out the 'followers_id' and finds them as a User

  has_many :followeds, class_name: 'Following', foreign_key: 'follower_id' #gives an array of "Following" objects where this user IS the follower
  has_many :people_you_follow, through: :followeds, source: :user




  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  private
  def downcase_email
    self.email.downcase! if email.present?
  end
end
