class Instruction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one :count_link, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, through: :taggings , :source => :tag
  has_many :steps, :dependent => :destroy

  after_initialize :custom_initialization

  searchable do
    text :name
    text :user_name do
      user.name
    end
    text :category_name do
      category.name
    end
    text :steps do
      steps.map { |step| step.name }
    end
  end



  def all_tags=(names)
    created_tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_initialize
    end
    self.tags = created_tags
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  private
  def custom_initialization
    # count_links = CountLink.create(count: 0, instruction_id: self.id)
  end
end
