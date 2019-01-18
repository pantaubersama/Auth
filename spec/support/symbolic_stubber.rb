module SymbolicStubber
  
  DEFAULT_REQUEST_HEADERS = {
      'Accept'          => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      => 'Ruby'
  }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_symbolic email, invite_code
    the_body = {
      "provider": "identitas",
      "uid": 333
    }
    stub_request(:post, "https://identitas.extrainteger.com/v1/internal/users/invite?email=#{email}&invite_code=#{invite_code}").
      with(
        headers: {
      'Authkey'=>'b6b5d4867a21c58e7cce9c0696595104056e30e70bd390cf2a5c1d1b560afd1c'
        }).
      to_return(status: 200, body: the_body.to_json, headers: {})
  end
  
end
