class AddColumtInstructions < ActiveRecord::Migration[5.1]
  def change
    add_column :instructions, :count_links, :integer, :default => 0
  end
end
