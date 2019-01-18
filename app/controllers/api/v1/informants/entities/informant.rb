module API
  module V1
    module Informants
      module Entities
        class Informant < Grape::Entity
          expose :user_id
          expose :identity_number, documentation: {desc: "Identity number"}
          expose :pob, documentation: {desc: "Place of birth"}
          expose :dob, documentation: {desc: "Date of birth [YYYY-MM-DD]", type: Date}
          expose :gender, documentation: {desc: "Gender <br> 0 => Female <br> 1 => Male", type: Integer, values: [0,1]}
          expose :gender_str do |obj, opt|
            case obj.gender
            when 1
              "Laki-laki"
            when 0
              "Perempuan"
            else
              nil
            end
          end
          expose :occupation, documentation: {desc: "Occupation"}
          expose :nationality, documentation: {desc: "Nationality"}
          expose :address, documentation: {desc: "Address"}
          expose :phone_number, documentation: {desc: "Phone number"}
        end
      end
    end
  end
end