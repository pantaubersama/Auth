module Subscribers
  class BadgeQuestionSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUESTION_ACHIEVED, env: nil

    def work(data)
      logger.info "Subscribers::BadgeQuestionSubscriber - #{data}"

      params = json_response data
      Badges::Question.new.run params

      logger.info "Subscribers::BadgeQuestionSubscriber finished"

      ack!
    end

  end
end
