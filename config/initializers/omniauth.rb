Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identitas, ENV["API_KEY"], ENV["API_SECRET"], client_options: {
    site: ENV["SYMBOLIC_URL"]
  }
  provider :twitter, ENV["TW_CONSUMER_KEY"], ENV["TW_CONSUMER_SECRET"]
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET']
end