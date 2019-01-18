module FacebookStubber

  DEFAULT_REQUEST_HEADERS = {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Faraday v0.11.0'
   }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_facebook_request t, s
    data = {
      "id" => "102058887556301",
      "email"=> "open_nporhpu_user@tfbnw.net"
    }.to_json

    stub_request(:get, "https://graph.facebook.com/v3.2/me?access_token=#{t}&fields=email").
      with(
        headers: DEFAULT_REQUEST_HEADERS).
      to_return(status: 200, body: data, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_invalidate_facebook_request t, uid
    data = {
      "success" => true
    }.to_json

    stub_request(:post, "https://graph.facebook.com/v3.2/#{uid}/permissions").
      with(
        body: {"access_token"=> t, "method"=>"delete"},
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v0.11.0'
        }).
      to_return(status: 200, body: "", headers: {})
  end

end