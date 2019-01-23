module Subscribers
  class QuizSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUIZ_ACHIEVED, env: nil

    def work(data)
      logger.info "Subscribers::QuizSubscriber - #{data}"

      params = json_response data
      Badges::Quiz.new.run params

      logger.info "Subscribers::QuizSubscriber finished"

      ack!
    end

  end
end