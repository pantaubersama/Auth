module API::V1::Badges::Entities
  class AchievedBadge < Grape::Entity
    expose :id, as: :achieved_id
    expose :badge, using: API::V1::Badges::Entities::Badge
    expose :user, using: Api::V1::Me::Entities::UserSimple
  end
end