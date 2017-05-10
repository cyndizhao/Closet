class Gender < ApplicationRecord
  has_many :posts, dependent: :nullify
end
