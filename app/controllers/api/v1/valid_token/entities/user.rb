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
        end
      end
    end
  end
end