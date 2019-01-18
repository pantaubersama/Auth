if !Rails.env.development? && !Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:      ENV['AWS_KEY_ID'],           # required
      aws_secret_access_key: ENV['AWS_KEY_SECRET'],        # required
      region:                'ap-southeast-1',             # optional, defaults to 'us-east-1'
      # host:                  's3.example.com',             # optional, defaults to nil
      # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = ENV['AWS_BUCKET_NAME']                          # required
    config.fog_public     = true                                        # optional, defaults to true
    config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
  end
end