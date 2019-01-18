class CreateAchievedBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :achieved_badges, id: :uuid do |t|
      t.uuid :badge_id
      t.uuid :user_id
      t.string :resource_type
      t.uuid :resource_id

      t.timestamps
    end
  end
end
