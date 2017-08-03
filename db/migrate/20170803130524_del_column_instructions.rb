class DelColumnInstructions < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructions, :count_links
  end
end
