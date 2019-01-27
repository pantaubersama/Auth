class SeedDefaultUser < SeedMigration::Migration
  def up
    if Rails.env.development? || Rails.env.test?
      User.find_or_create_by(email: "helmy@extrainteger.com", id: "c9242c5a-805b-4ef5-b3a7-2a7f25785cc8", full_name: "Yunan Helmy")
      User.find_or_create_by(email: "hanifsgy@gmail.com", id: "e90ae078-f617-4a32-bcaa-0865041db0e6", full_name: "Hanif Sugiyanto")
      User.find_or_create_by(email: "namakukingkong@gmail.com", id: "1036fd3c-04ed-4949-b57c-b7dc8ff3e737", full_name: "Joan Weeks")
    end
  end

  def down

  end
end
