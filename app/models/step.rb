class Step < ApplicationRecord
  belongs_to :instruction
  has_many :blocks, :dependent => :destroy
  PERPAGE=10
  self.per_page = PERPAGE
end
