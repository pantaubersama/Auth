module Subscribers
  class BadgeSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_ACHIEVED, env: nil

    def work(data)
      logger.info "Subscribers::BadgeSubscriber - #{data}"

      params = json_response data
      Badges::Question.new.run params

      logger.info "Subscribers::BadgeSubscriber finished"

      ack!
    end

  end
end
