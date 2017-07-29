class SetDefaultAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :image, :string, :default => "http://res.cloudinary.com/dpoas7y00/image/upload/v1501151345/noavatar_dmmu1e.png"
  end
end
