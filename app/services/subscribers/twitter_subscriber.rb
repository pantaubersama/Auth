module Subscribers
  class TwitterSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue "post.twitter", env: nil

    def work(data)
      logger.info "Subscribers::TwitterSubscriber - #{data}"

      params  = json_response data
      account = Account.find_by(user_id: params["user_id"], account_type: "twitter")
      api     = TwitterApi::Main.new account.access_token, account.access_token_secret
      api.tweet params["message"]

      logger.info "Subscribers::TwitterSubscriber finished"

      ack!
    end

  end
end