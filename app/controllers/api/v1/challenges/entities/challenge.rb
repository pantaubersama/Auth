module API::V1::Challenges::Entities
  class Challenge < Grape::Entity
    expose :invite_code
    expose :invitation_id
    expose :type
    expose :accepted_at
  end
end