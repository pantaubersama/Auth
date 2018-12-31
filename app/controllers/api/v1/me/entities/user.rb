class Api::V1::Me::Entities::User < Api::V1::ValidToken::Entities::User
  expose :username
  expose :about
  expose :location
  expose :education
  expose :occupation
  expose :avatar
end