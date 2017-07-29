class Step < ApplicationRecord
  belongs_to :instruction
  has_many :blocks
end
