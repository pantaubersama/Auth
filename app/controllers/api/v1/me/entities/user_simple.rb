class Api::V1::Me::Entities::UserSimple < Grape::Entity
  expose :id
  expose :email
  expose :first_name
  expose :last_name
  expose :username
  expose :avatar
  expose :verified
end