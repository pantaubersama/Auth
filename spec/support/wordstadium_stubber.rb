module WordstadiumStubber
  WORDSTADIUM_BASE_URL   = ENV['WORDSTADIUM_BASE_URL']

  DEFAULT_REQUEST_HEADERS = {
      'Accept'          => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      => 'Ruby'
  }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_accept_success token, invite_code
    body = {
      data: {
        message: "Tantangan Diterima!"
      }
    }
    stub_request(:put, "#{WORDSTADIUM_BASE_URL}/word_stadium/v1/challenges/direct/approve").
      with(
        body: {
          invite_code: invite_code
        }.to_query,
        headers: {
          'Authorization'=> token
        }).
      to_return(status: 200, body: body.to_json, headers: {})
  end

  def stub_accept_failed token, invite_code
    body = {
      errors: ["Gagal menerima tantangan!"]
    }
    stub_request(:put, "#{WORDSTADIUM_BASE_URL}/word_stadium/v1/challenges/direct/approve").
      with(
        body: {
          invite_code: invite_code
        }.to_query,
        headers: {
          'Authorization'=> token
        }).
      to_return(status: 200, body: body.to_json, headers: {})
  end
end