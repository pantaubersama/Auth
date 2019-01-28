Searchkick.redis          = Redis.new url: ENV["REDIS_SERVER_URL"]
Searchkick.client_options = {
  url:              ENV['ELASTICSEARCH_URL'],
  retry_on_failure: true,
  transport_options:
                    { request: { timeout: 250 } }
}

elastic_auth_config         = {
  host:              ENV['ELASTICSEARCH_AUTH_URL'],
  retry_on_failure:  true,
  transport_options: {
    request: { timeout: 250 }
  }
}
Elasticsearch::Model.client = Elasticsearch::Client.new(elastic_auth_config)
