class KuisBadge < SeedMigration::Migration
  def up
    b = Badge.find_by code: "kuis"
    b.update_attribute(:code, "kuis1")
  end

  def down

  end
end
