class AddScopeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :scopes, :string
  end
end
