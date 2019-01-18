class SeedConfidentialApp < SeedMigration::Migration
  def up
    d = Doorkeeper::Application.create name: "Confidential App", confidential: true, redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
  end

  def down

  end
end
