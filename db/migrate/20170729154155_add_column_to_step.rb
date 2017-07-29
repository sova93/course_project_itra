class AddColumnToStep < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :instruction_id, :integer
  end

  def up
    add_column :steps, :instruction_id, :integer
  end

  def down
    remove_column :steps, :instruction_id
  end
end
