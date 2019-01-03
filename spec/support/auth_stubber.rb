module AuthStubber
  AUTH_BASE_URL   = ENV['AUTH_BASE_URL']
  VERIFY_ENDPOINT = ENV['VERIFY_ENDPOINT']

  DEFAULT_REQUEST_HEADERS = {
      'Accept'          => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      => 'Ruby'
  }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_credentials_request token
    the_body = {
      "info": {
        "id": 2,
        "email": "helmy@extrainteger.com",
        "full_name": "Yunan Helmy",
        "name": "Yunan Helmy",
        "invitation_accepted_at": nil,
        "invitations_count": 8
      },
      "uid": 2,
      "provider": "identitas"
    }.to_json

    stub_request(:get, "https://identitas.extrainteger.com/v1/me?access_token=#{token}").
      with(
        headers: DEFAULT_REQUEST_HEADERS).
      to_return(status: 200, body: the_body, headers: {})
  end

  def stub_credential_verify token
    the_body = {
      "data": {
        "info": {
          "id": 2,
          "email": "helmy@extrainteger.com",
          "full_name": "Yunan Helmy",
          "name": "Yunan Helmy",
          "invitation_accepted_at": nil,
          "invitations_count": 8
        },
        "uid": 2,
        "provider": "identitas"
      },
      "credentials": {
        "access_token": "351b5a11ba7518a08714554e891c1364afbd7da77a61a52f13cfc6c34086c091",
        "scopes": "",
        "application_id": "ad68192bfcfe8085492dc82af35e26c8ca92a8d08db9e9d7820e054a849d5add"
      }
    }.to_json

    stub_request(:get, "https://identitas.extrainteger.com/v1/verify_credential?access_token=#{token}").
      with(
        headers: DEFAULT_REQUEST_HEADERS).
      to_return(status: 200, body: the_body, headers: {})
  end
  
end
