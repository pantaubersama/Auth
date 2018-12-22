module Api
  module V1
    module ValidToken
      module Entities
        class Cluster < Grape::Entity
          expose :id
          expose :name
        end
      end
    end
  end
end