class Api::V1::Me::Entities::User < Api::V1::ValidToken::Entities::User
  expose :username
  expose :about
  expose :location
  expose :education
  expose :occupation
  expose :avatar
  expose :cluster, using: API::V1::Clusters::Entities::ClusterDetail
  expose :informant, using: API::V1::Informants::Entities::Informant
end