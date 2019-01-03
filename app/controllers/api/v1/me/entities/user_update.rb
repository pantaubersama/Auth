class Api::V1::Me::Entities::UserUpdate < Grape::Entity
  expose :id
  expose :email
  expose :full_name, documentation: {type: String, desc: "Full Name"}
  expose :username, documentation: {type: String, desc: "Username (without @)"}
  expose :about, documentation: {type: String, desc: "About"}
  expose :location, documentation: {type: String, desc: "Location"}
  expose :education, documentation: {type: String, desc: "Education"}
  expose :occupation, documentation: {type: String, desc: "Occupation"}
end