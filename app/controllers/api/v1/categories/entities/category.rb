module API::V1::Categories::Entities
  class Category < Grape::Entity
    expose :id
    expose :name
  end
end