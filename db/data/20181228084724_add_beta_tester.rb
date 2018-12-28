class AddBetaTester < SeedMigration::Migration
  def up
    Badge.create name: "Beta Tester", description: "Kamu berpartisipasi dalam beta testing", position: 1
  end

  def down

  end
end
