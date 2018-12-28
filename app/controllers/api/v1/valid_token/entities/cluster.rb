module Api
  module V1
    module ValidToken
      module Entities
        class Cluster < Grape::Entity
          expose :id
          expose :name
          expose :is_eligible
          expose :image
        end
      end
    end
  end
end