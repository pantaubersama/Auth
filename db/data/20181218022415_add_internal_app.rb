class AddInternalApp < SeedMigration::Migration
  def up
    app = Doorkeeper::Application.create name: "Internal App", redirect_uri: "urn:ietf:wg:oauth:2.0:oob", confidential: false
  end

  def down

  end
end
