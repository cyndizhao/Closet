class Item < ApplicationRecord
  belongs_to :post
  belongs_to :brand

  validates :post_id, presence: true
  validates :brand_id, presence: true
  validates :price, presence: true
  validates :kind, presence: true
  validates :detail, presence: true
  validates :x, presence: true
  validates :y, presence: true
  #add name to item : name

  def self.search(search)
    where("detail ILIKE ?", "%#{search}%") 
  end
end
