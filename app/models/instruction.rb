class Instruction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :taggings
  has_many :tags, through: :taggings , :source => :tag
  has_many :steps

  def all_tags=(names)
    created_tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_initialize
    end
    self.tags = created_tags
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
