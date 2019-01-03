class API::V1::Me::Entities::FirebaseKey < Grape::Entity
  expose :key_type
  expose :content
  expose :user_id
end