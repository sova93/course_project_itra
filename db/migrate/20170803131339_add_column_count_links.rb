class AddColumnCountLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :count_links, :instruction_id, :integer
  end
end
