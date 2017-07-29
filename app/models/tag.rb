class Tag < ApplicationRecord
  has_many :taggings
  has_many :instructions, through: :taggings
end
