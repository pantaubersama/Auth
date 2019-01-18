module Api
  module V1
    module Callback
      module Entities
        class AccessToken < Grape::Entity
          expose :access_token do |access_token|
            access_token.token
          end
          expose :scopes do |access_token|
            access_token.scopes
          end
          expose :token_type do |access_token|
            "bearer"
          end
          expose :expires_in
          expose :refresh_token
          expose :created_at do |access_token|
            access_token.created_at.to_i
          end
        end
      end
    end
  end
end