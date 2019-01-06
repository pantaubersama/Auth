class RepopulateCLuster < SeedMigration::Migration
  def up
    Cluster.find_each do |c|
      c.create_magic_link
    end
  end

  def down

  end
end
