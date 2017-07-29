class ChangeBlocks < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :name, :string
    add_column :blocks, :type, :string
    add_column :blocks, :step_id, :integer
  end
end
