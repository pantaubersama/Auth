module Subscribers
  class JanjiSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_JANJI_ACHIEVED, env: nil

    def work(data)
      logger.info "Subscribers::JanjiSubscriber - #{data}"

      params = json_response data
      Badges::Janji.new.run params

      logger.info "Subscribers::JanjiSubscriber finished"

      ack!
    end

  end
end
