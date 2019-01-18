Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identitas, ENV["API_KEY"], ENV["API_SECRET"], client_options: {
    site: ENV["SYMBOLIC_URL"]
  }
end