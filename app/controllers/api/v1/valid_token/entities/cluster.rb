module Api
  module V1
    module ValidToken
      module Entities
        class Cluster < Grape::Entity
          expose :id
          expose :name
          expose :description
          expose :is_eligible
          expose :is_displayed
          expose :image
          expose :members_count
          expose :category, using: API::V1::Categories::Entities::Category
        end
      end
    end
  end
end