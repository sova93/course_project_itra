class SetDefaultToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :theme, :default => "light"
  end
end
