module Subscribers
  class JanjiSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_JANJI_ACHIEVED, env: nil, timeout_job_after: 1.minutes

    def work(data)
      ActiveRecord::Base.connection_pool.with_connection do
        logger.info "Subscribers::JanjiSubscriber - #{data}"

        params = json_response data
        Badges::Janji.new.run params

        logger.info "Subscribers::JanjiSubscriber finished"
      end

      ack!
    end

  end
end
