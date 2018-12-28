module API
  module V1
    module Clusters
      module Entities
        class ClusterSimple < Grape::Entity
          expose :id
          expose :name
          expose :image
          expose :is_displayed
        end
      end
    end
  end
end