class ChangeColumnType < ActiveRecord::Migration[5.1]
  def change
    rename_column :blocks, :type, :block_type
  end
end
