module API::V1::Categories::Entities
  class Category < Grape::Entity
    expose :id
    expose :name
    expose :description
    expose :created_at
    expose :creator
  end
end