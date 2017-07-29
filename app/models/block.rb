class Block < ApplicationRecord
  belongs_to :step
  enum type: [:text, :image, :video]
end
