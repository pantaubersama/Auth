module Publishers
  class QuestionNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::QuestionNotification.publish exchange, message
      #  - exchange: "pemilu.question"
      #  - message:
      #         - {count: 100, notif_type: :question, event_type: :upvote_repot }
      #         - {quiz_id: UUID, notif_type: :question, event_type: :upvote_repot }
      #         - {quiz_id: UUID, receiver_id: UUID,user_action_id: UUID, notif_type: :question, event_type: :upvote_repot }
      push exchange, message, :notification
    end
  end
end