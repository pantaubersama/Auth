module Subscribers
  class QuestionSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUESTION_ACHIEVED, env: nil

    def work(data)
      logger.info "Subscribers::QuestionSubscriber - #{data}"

      params = json_response data
      Badges::Question.new.run params

      logger.info "Subscribers::QuestionSubscriber finished"

      ack!
    end

  end
end
