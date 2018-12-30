module API::V1::Clusters::Entities
  class ClusterDetail < API::V1::Clusters::Entities::Cluster
    expose :users_count
  end
end