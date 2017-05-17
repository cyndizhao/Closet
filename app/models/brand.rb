class Brand < ApplicationRecord
  has_many :items, dependent: :destroy
  validates(:name, { presence: true, uniqueness: true})

  # def self.search(search)
  #   where("name ILIKE ?", "%#{search}%")
  # end
end
