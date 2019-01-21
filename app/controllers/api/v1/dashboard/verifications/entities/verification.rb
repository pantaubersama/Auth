module API
  module V1
    module Dashboard
      module Verifications
        module Entities
          class Verification < Grape::Entity
            expose :user_id
            expose :ktp_number
            expose :ktp_selfie
            expose :ktp_photo
            expose :signature
            expose :approved
            expose :step
            expose :user, with: Api::V1::Me::Entities::User
          end
        end
      end
    end
  end
end