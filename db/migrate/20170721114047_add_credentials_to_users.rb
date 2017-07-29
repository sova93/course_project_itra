class AddCredentialsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :about, :text
    add_column :users, :hobbies, :text
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :phone, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end
