class Api::V1::Me::Entities::UserUpdate < Grape::Entity
  expose :id
  expose :email
  expose :first_name, documentation: {type: String, desc: "First Name"}
  expose :last_name, documentation: {type: String, desc: "First Name"}
  expose :username, documentation: {type: String, desc: "Username (without @)"}
  expose :about, documentation: {type: String, desc: "About"}
  expose :location, documentation: {type: String, desc: "Location"}
  expose :education, documentation: {type: String, desc: "Education"}
  expose :occupation, documentation: {type: String, desc: "Occupation"}
end