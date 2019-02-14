class Api::V1::Dashboard::Verifications::Entities::User < Grape::Entity
  expose :id
  expose :email
  expose :full_name
  expose :username
  expose :avatar
  expose :verified
  expose :about
  expose :twitter do |obj, opts|
    obj.twitter?
  end
  expose :facebook do |obj, opts|
    obj.facebook?
  end
  expose :cluster, using: API::V1::Clusters::Entities::ClusterDetail
  expose :status_verification
  expose :sent_at_verification
  expose :note do |obj, opts|
    ::User.find(obj.id).note rescue nil
  end
end