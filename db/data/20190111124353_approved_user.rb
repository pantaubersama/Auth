class ApprovedUser < SeedMigration::Migration
  def up
    Verification.all.each do |v|
      v.verified! if v.approved?
    end
  end

  def down

  end
end
