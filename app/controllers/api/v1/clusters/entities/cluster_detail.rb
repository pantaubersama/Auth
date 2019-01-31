module API::V1::Clusters::Entities
  class ClusterDetail < API::V1::Clusters::Entities::Cluster
    expose :members_count
    expose :is_eligible
    expose :magic_link
    expose :is_link_active
    expose :status
    expose :requester, using: API::V1::Clusters::Entities::Requester, if: lambda { |c,o| o[:current_user].present? && o[:current_user].is_admin? }
    expose :created_at
  end
end