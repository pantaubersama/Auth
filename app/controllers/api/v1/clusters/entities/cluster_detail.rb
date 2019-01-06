module API::V1::Clusters::Entities
  class ClusterDetail < API::V1::Clusters::Entities::Cluster
    expose :members_count
    expose :is_eligible
    expose :magic_link
    expose :is_link_active
  end
end