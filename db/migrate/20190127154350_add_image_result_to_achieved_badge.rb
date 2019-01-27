class AddImageResultToAchievedBadge < ActiveRecord::Migration[5.2]
  def change
    add_column :achieved_badges, :image_result, :string
  end
end
