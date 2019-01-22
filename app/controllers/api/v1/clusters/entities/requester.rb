module API::V1::Clusters::Entities
  class Requester < Grape::Entity
    expose :id
    expose :full_name
  end
end