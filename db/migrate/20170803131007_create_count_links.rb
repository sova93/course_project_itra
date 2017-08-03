class CreateCountLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :count_links do |t|
      t.integer :cout

      t.timestamps
    end
  end
end
