module Subscribers
  class BadgeQuestionUpvotingSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUESTION_UPVOTING, env: nil

    def work(data)
      logger.info "Subscribers::BadgeQuestionUpvotingSubscriber - #{data}"

      params = json_response data
      Badges::QuestionUpvoting.new.run params

      logger.info "Subscribers::BadgeQuestionUpvotingSubscriber finished"

      ack!
    end

  end
end
