class AddVotePreferenceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :vote_preference, :integer
  end
end
