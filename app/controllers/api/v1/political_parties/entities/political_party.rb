module API
  module V1
    module PoliticalParties
      module Entities
        class PoliticalParty < Grape::Entity
          expose :name
          expose :image
        end
      end
    end
  end
end