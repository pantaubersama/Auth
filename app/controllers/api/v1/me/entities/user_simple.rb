class Api::V1::Me::Entities::UserSimple < Grape::Entity
  expose :id
  expose :email
  expose :full_name
  expose :username
  expose :avatar
  expose :verified
  expose :about
  expose :location
  expose :education
  expose :occupation
  expose :twitter do |obj, opts|
    obj.twitter?
  end
  expose :facebook do |obj, opts|
    obj.facebook?
  end
  expose :cluster, using: API::V1::Clusters::Entities::ClusterDetail
  expose :created_at
end