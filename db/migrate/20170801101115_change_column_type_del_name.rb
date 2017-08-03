class ChangeColumnTypeDelName < ActiveRecord::Migration[5.1]
  def change
    change_column :blocks, :block_type, :integer
    remove_column :blocks, :name
  end
end
