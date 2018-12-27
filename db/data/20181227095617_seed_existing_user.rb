class SeedExistingUser < SeedMigration::Migration
  def up
    User.all.each do |u|
      u.build_verification_model
    end
  end

  def down

  end
end
