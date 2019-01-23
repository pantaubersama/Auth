module API
  module V1
    module PoliticalParties
      module Entities
        class PoliticalParty < Grape::Entity
          expose :id
          expose :name
          expose :image
          expose :number
        end
      end
    end
  end
end