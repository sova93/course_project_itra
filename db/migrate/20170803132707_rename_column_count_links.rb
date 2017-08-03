class RenameColumnCountLinks < ActiveRecord::Migration[5.1]
  def change
    rename_column :count_links, :cout, :count
  end
end
