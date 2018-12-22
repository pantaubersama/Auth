class Api::V1::Me::Entities::User < Grape::Entity
  expose :id
  expose :email
  expose :first_name
  expose :last_name
  expose :avatar
  expose :username
  expose :about
  expose :location
  expose :education
  expose :occupation
  expose :verified
end