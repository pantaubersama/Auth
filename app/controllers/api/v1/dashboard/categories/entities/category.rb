module API::V1::Dashboard::Categories::Entities
  class Category < Grape::Entity
    expose :id
    expose :name
    expose :description
  end
end