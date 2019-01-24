class ChangeTanyaInteraksi < SeedMigration::Migration
  def up
    changes = ["tanyainteraksi200", "tanyainteraksi500", "tanyainteraksi1000"]
    ["tanya200", "tanya500", "tanya1000"].each_with_index do |bc, i|
      Badge.find_by(code: bc).update_attribute(:code, changes[i])
    end
  end

  def down

  end
end
