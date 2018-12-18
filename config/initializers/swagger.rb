GrapeSwaggerRails.options.before_action do |request|
  # unless user = authenticate_with_http_basic { |u, p| u == ENV["DOC_USERNAME"] && p == ENV["DOC_PASSWORD"] }
  #   request_http_basic_authentication
  # end
end