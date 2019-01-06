module API::V1::Clusters::Entities
  class ClusterDetail < API::V1::Clusters::Entities::Cluster
    expose :members_count
    expose :is_eligible
  end
end