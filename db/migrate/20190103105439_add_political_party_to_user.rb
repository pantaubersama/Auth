class AddPoliticalPartyToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :political_party_id, :uuid
  end
end
