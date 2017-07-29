class ChangeColumnInstructionModelName < ActiveRecord::Migration[5.1]
  def change
    rename_column :instructions, :category, :category_id
  end
end
