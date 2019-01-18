module Api
  module V1
    module ValidToken
      module Entities
        class User < Grape::Entity
          expose :id
          expose :email
          expose :full_name
          expose :uid
          expose :provider
          expose :avatar
          expose :is_admin do |u, opt|
            u.is_admin?
          end
          expose :is_moderator
          expose :cluster, using: API::V1::Clusters::Entities::ClusterDetail
          expose :vote_preference
          expose :political_party, using: API::V1::PoliticalParties::Entities::PoliticalParty
          expose :verified
          expose :twitter do |obj, opts|
            obj.twitter?
          end
          expose :facebook do |obj, opts|
            obj.facebook?
          end
        end
      end
    end
  end
end