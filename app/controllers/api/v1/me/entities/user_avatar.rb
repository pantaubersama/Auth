class Api::V1::Me::Entities::UserAvatar < Grape::Entity
  expose :avatar, documentation: {type: File, desc: "Avatar"}
end