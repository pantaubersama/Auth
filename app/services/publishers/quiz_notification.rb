module Publishers
  class QuizNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::QuizNotification.publish exchange, message
      #  - exchange: "pemilu.quiz"
      #  - message:
      #         - {quiz_id: UUID, notif_type: :quiz, event_type: :quiz_created }
      push exchange, message, :notification
    end
  end
end