module Subscribers
  class QuizSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUIZ_ACHIEVED, env: nil, timeout_job_after: 1.minutes

    def work(data)
      ActiveRecord::Base.connection_pool.with_connection do
        logger.info "Subscribers::QuizSubscriber - #{data}"

        params = json_response data
        Badges::Quiz.new.run params

        logger.info "Subscribers::QuizSubscriber finished"
      end

      ack!
    end

  end
end