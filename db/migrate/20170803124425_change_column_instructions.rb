class ChangeColumnInstructions < ActiveRecord::Migration[5.1]
  def change
    change_column :instructions, :count_links, :integer, :default => 0
  end
end
