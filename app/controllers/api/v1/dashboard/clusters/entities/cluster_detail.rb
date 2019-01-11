module API::V1::Dashboard::Clusters::Entities
  class ClusterDetail < API::V1::Clusters::Entities::ClusterDetail
    expose :status
  end
end