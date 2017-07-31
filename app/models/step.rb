class Step < ApplicationRecord
  belongs_to :instruction
  has_many :blocks, :dependent => :delete_all
end
