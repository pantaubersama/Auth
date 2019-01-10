Koala.configure do |config|
  config.app_id = ENV["FB_APP_ID"]
  config.app_secret = ENV["FB_APP_SECRET"]
  config.api_version = "v3.2"
end