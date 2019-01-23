module Subscribers
  class QuestionUpvotingSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUESTION_UPVOTING, env: nil

    def work(data)
      logger.info "Subscribers::QuestionUpvotingSubscriber - #{data}"

      params = json_response data
      Badges::QuestionUpvoting.new.run params

      logger.info "Subscribers::QuestionUpvotingSubscriber finished"

      ack!
    end

  end
end
