class Api::V1::Me::Entities::UserSimple < Grape::Entity
  expose :id
  expose :email
  expose :full_name
  expose :username
  expose :avatar
  expose :verified
  expose :about
end