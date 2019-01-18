class ChangeToFullName < SeedMigration::Migration
  def up
    User.find_each do |user|
      user.full_name = [user.first_name, user.last_name].join(" ")
      user.save!
    end
  end

  def down

  end
end
