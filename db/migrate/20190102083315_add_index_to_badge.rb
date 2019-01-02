class AddIndexToBadge < ActiveRecord::Migration[5.2]
  def change
    add_index :achieved_badges, [:user_id, :badge_id], unique: true
  end
end
