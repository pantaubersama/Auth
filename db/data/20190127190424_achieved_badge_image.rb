class AchievedBadgeImage < SeedMigration::Migration
  def up
    AchievedBadge.where.not(user: nil, badge: nil).find_each do |a|
      a.create_image
    end
  end

  def down

  end
end
