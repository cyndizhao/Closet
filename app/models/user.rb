class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_attached_file :selfie, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :selfie, content_type: /\Aimage\/.*\z/

  has_many :followings # gives an array of "Following" objects where this user is this one being followed
  has_many :followers, through: :followings # takes the `followings` takes out the 'followers_id' and finds them as a User

  has_many :followeds, class_name: 'Following', foreign_key: 'follower_id' #gives an array of "Following" objects where this user IS the follower
  has_many :people_you_follow, through: :followeds, source: :user




  has_secure_password

  validates :first_name, presence: true, unless: :is_business_user?
  validates :last_name, presence: true, unless: :is_business_user?
  validates :company_name, presence: true, if: :is_business_user?
  validates :business_user, inclusion: { in: [ true, false ] }, default: false
  # validates :description, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  def followed_users
    User.select('users.*','followings.id AS following_id').joins(:followings).where('followings.follower_id = ?', self.id)
  end

  def find_following_id_for_specific_followed_user(followed_people)
    User.select('users.*','followings.id AS following_id').joins(:followings).where('followings.follower_id = ?', self.id).find_by_id(followed_people).following_id
  end

  def find_whether_you_followed_the_person(followed_people)
    User.select('users.*','followings.id AS following_id').joins(:followings).where('followings.follower_id = ?', self.id).find_by_id(followed_people)
  end

  def self.search_name(search)
    # where("first_name ILIKE ? OR last_name ILIKE ?", "%#{search}%", "%#{search}%")
    where("lower(first_name || ' ' || last_name) ILIKE ?", "%#{search.downcase}%")
  end

  private
  def downcase_email
    self.email.downcase! if email.present?
  end

  def is_business_user?
    business_user == true
  end
end
