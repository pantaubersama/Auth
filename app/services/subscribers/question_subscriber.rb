module Subscribers
  class QuestionSubscriber < ApplicationSubscriber
    include Sneakers::Worker
    from_queue BADGE_QUESTION_ACHIEVED, env: nil, timeout_job_after: 1.minutes

    def work(data)
      ActiveRecord::Base.connection_pool.with_connection do
        logger.info "Subscribers::QuestionSubscriber - #{data}"

        params = json_response data
        Badges::Question.new.run params

        logger.info "Subscribers::QuestionSubscriber finished"
      end

      ack!
    end

  end
end
