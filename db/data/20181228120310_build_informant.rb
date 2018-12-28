class BuildInformant < SeedMigration::Migration
  def up
    User.all.each do |u|
      u.build_informant_model
    end
  end

  def down

  end
end
