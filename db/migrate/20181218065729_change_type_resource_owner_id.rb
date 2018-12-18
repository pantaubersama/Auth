class ChangeTypeResourceOwnerId < ActiveRecord::Migration[5.2]
  def change
    change_column :oauth_access_grants, :resource_owner_id, :string
    change_column :oauth_access_tokens, :resource_owner_id, :string
  end
end
