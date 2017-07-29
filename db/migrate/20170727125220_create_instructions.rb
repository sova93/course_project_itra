class CreateInstructions < ActiveRecord::Migration[5.1]
  def change
    create_table :instructions do |t|
      t.string :name
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
