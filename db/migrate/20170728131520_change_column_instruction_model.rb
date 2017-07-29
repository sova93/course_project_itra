class ChangeColumnInstructionModel < ActiveRecord::Migration[5.1]
  def change
    change_column(:instructions, :category, :integer)
  end

  def up
    change_column :instructions, :category, :integer
  end

  def down
    change_column :instructions, :category, :string
  end
end
