class SeedClusterTimses < SeedMigration::Migration
  def up
    Cluster.create name: "Tim Sukses Paslon 1"
    Cluster.create name: "Tim Sukses Paslon 2"
  end

  def down

  end
end
