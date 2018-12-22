class AddAvatarToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string
    add_column :users, :username, :string, index: true
    add_column :users, :about, :text
    add_column :users, :verified, :boolean, default: false
    add_column :users, :location, :string
    add_column :users, :education, :string
    add_column :users, :occupation, :string
  end
end
