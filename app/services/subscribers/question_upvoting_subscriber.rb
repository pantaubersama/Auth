module Subscribers
  class QuestionUpvotingSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUESTION_UPVOTING, env: nil, timeout_job_after: 1.minutes

    def work(data)
      ActiveRecord::Base.connection_pool.with_connection do
        logger.info "Subscribers::QuestionUpvotingSubscriber - #{data}"

        params = json_response data
        Badges::QuestionUpvoting.new.run params

        logger.info "Subscribers::QuestionUpvotingSubscriber finished"
      end

      ack!
    end

  end
end
