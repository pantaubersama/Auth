class RemoveVerifiedfromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :verified, :boolean, default: false
  end
end
