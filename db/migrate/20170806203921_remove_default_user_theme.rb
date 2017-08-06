class RemoveDefaultUserTheme < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :theme, :string, :default => nil
  end
end
