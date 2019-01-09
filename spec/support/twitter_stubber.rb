module TwitterStubber

  DEFAULT_REQUEST_HEADERS = {
    'Accept'=>'application/json',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'Authorization'=>'OAuth oauth_consumer_key="gnWWCXI8Ki255KFtEyWcIcYrh", oauth_nonce="18b9c3e5aea7deff6ae56c8c5a9ad77c", oauth_signature="i8up6LZ570OT4UCMaHkFqNROzVU%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1547010569", oauth_token="YOUR_TOKEN", oauth_version="1.0"',
    'User-Agent'=>'TwitterRubyGem/6.1.0'
  }.freeze

  DEFAULT_RESPONSE_HEADERS = { 'Content-Type' => 'application/json' }.freeze

  def stub_twitter_request t, s
    data = {
      "contributors_enabled": true,
      "created_at": "Sat May 09 17:58:22 +0000 2009",
      "default_profile": false,
      "default_profile_image": false,
      "description": "I taught your phone that thing you like.  The Mobile Partner Engineer @Twitter. ",
      "favourites_count": 588,
      "follow_request_sent": nil,
      "followers_count": 10625,
      "following": nil,
      "friends_count": 1181,
      "geo_enabled": true,
      "id": 38895958,
      "id_str": "38895958",
      "email": "hello@dummy.com",
      "is_translator": false,
      "lang": "en",
      "listed_count": 190,
      "location": "San Francisco",
      "name": "Sean Cook",
      "notifications": nil,
      "profile_background_color": "1A1B1F",
      "profile_background_image_url": "http://a0.twimg.com/profile_background_images/495742332/purty_wood.png",
      "profile_background_image_url_https": "https://si0.twimg.com/profile_background_images/495742332/purty_wood.png",
      "profile_background_tile": true,
      "profile_image_url": "http://a0.twimg.com/profile_images/1751506047/dead_sexy_normal.JPG",
      "profile_image_url_https": "https://si0.twimg.com/profile_images/1751506047/dead_sexy_normal.JPG",
      "profile_link_color": "2FC2EF",
      "profile_sidebar_border_color": "181A1E",
      "profile_sidebar_fill_color": "252429",
      "profile_text_color": "666666",
      "profile_use_background_image": true,
      "protected": false,
      "screen_name": "theSeanCook",
      "show_all_inline_media": true,
      "status": {
          "contributors": nil,
          "coordinates": {
              "coordinates": [
                  -122.45037293,
                  37.76484123
              ],
              "type": "Point"
          },
          "created_at": "Tue Aug 28 05:44:24 +0000 2012",
          "favorited": false,
          "geo": {
              "coordinates": [
                  37.76484123,
                  -122.45037293
              ],
              "type": "Point"
          },
          "id": 240323931419062272,
          "id_str": "240323931419062272",
          "in_reply_to_screen_name": "messl",
          "in_reply_to_status_id": 240316959173009410,
          "in_reply_to_status_id_str": "240316959173009410",
          "in_reply_to_user_id": 18707866,
          "in_reply_to_user_id_str": "18707866",
          "place": {
              "attributes": {},
              "bounding_box": {
                  "coordinates": [
                      [
                          [
                              -122.45778216,
                              37.75932999
                          ],
                          [
                              -122.44248216,
                              37.75932999
                          ],
                          [
                              -122.44248216,
                              37.76752899
                          ],
                          [
                              -122.45778216,
                              37.76752899
                          ]
                      ]
                  ],
                  "type": "Polygon"
              },
              "country": "United States",
              "country_code": "US",
              "full_name": "Ashbury Heights, San Francisco",
              "id": "866269c983527d5a",
              "name": "Ashbury Heights",
              "place_type": "neighborhood",
              "url": "http://api.twitter.com/1/geo/id/866269c983527d5a.json"
          },
          "retweet_count": 0,
          "retweeted": false,
          "source": "Twitter for  iPhone",
          "text": "@messl congrats! So happy for all 3 of you.",
          "truncated": false
      },
      "statuses_count": 2609,
      "time_zone": "Pacific Time (US & Canada)",
      "url": nil,
      "utc_offset": -28800,
      "verified": false
    }.to_json

    stub_request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true").
      to_return(status: 200, body: data, headers: DEFAULT_RESPONSE_HEADERS)
  end

  def stub_twitter_request_invalidate t, se
    stub_request(:post, "https://api.twitter.com/1.1/oauth/invalidate_token.json").
      to_return(status: 200, body: {access_token: t}.to_json, headers: DEFAULT_RESPONSE_HEADERS)
  end
  
end