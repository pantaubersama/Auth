class API::V1::HelloWorlds::Resources::HelloWorlds < Grape::API
  include API::V1::Config
  resource "hello_worlds" do
    desc "Version"
    get "version" do
      results = {version: "v1"}
      present results
    end
    desc "Welcome"
    get "hello" do
      results = {messages: "Hello World"}
      present results
    end
    desc "Bye"
    get "bye" do
      error!("bye bye!", 404)
    end
  end
end
