class SeedNumberParty < SeedMigration::Migration
  def up
    PoliticalParty.order("created_at asc").each_with_index do |p, i|
      n = i + 1
      p.update_attribute(:number, n)
    end
  end

  def down

  end
end
