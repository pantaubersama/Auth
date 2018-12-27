module API
  module V1
    module Verifications
      module Entities
        class Verification < Grape::Entity
          expose :user_id
          # expose :ktp_number
          # expose :ktp_selfie
          # expose :ktp_photo
          # expose :signature
          expose :approved
          expose :step
          expose :next_step do |v, o|
            v.step.to_i + 1
          end
          expose :is_verified do |v, o|
            v.is_verified?
          end
        end
      end
    end
  end
end