class Block < ApplicationRecord
  belongs_to :step
  enum block_type: [:text, :image, :video]
end
