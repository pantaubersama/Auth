module Api
  module V1
    module ValidToken
      module Entities
        class User < Grape::Entity
          expose :id
          expose :email
          expose :first_name
          expose :last_name
          expose :uid
          expose :provider
          expose :is_admin do |u, opt|
            u.is_admin?
          end
          expose :is_moderator
          expose :cluster, using: Api::V1::ValidToken::Entities::Cluster
          expose :vote_preference
          expose :verified
          
        end
      end
    end
  end
end