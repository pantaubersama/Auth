class API::V1::Dashboard::Clusters::Resources::Clusters < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "clusters" do
    desc 'Approve cluster request' do
      headers AUTHORIZATION_HEADERS
      detail "Approve cluster request"
    end
    oauth2
    params do
      requires :id, type: String, desc: "Cluster ID"
    end
    post "/approve/:id" do
      authorize_admin!
      cluster = ::Cluster.find params.id
      error!("Cluster sudah di set `tidak di setujui` (Rejected)", 403) if cluster.rejected?
      cluster.approve!
      present :cluster, cluster, with: API::V1::Clusters::Entities.ClusterDetail
    end

    desc 'Reject cluster request' do
      headers AUTHORIZATION_HEADERS
      detail "reject cluster request"
    end
    oauth2
    params do
      requires :id, type: String, desc: "Cluster ID"
    end
    post "/reject/:id" do
      authorize_admin!
      cluster = ::Cluster.find params.id
      error!("Cluster sudah di setujui (Approved)", 403) if cluster.approved?
      cluster.reject!
      present :cluster, cluster, with: API::V1::Clusters::Entities.ClusterDetail
    end

    desc 'Make user as memeber cluster' do
      headers AUTHORIZATION_HEADERS
      detail "Make user as memebr cluster"
    end
    oauth2
    params do
      requires :id, type: String, desc: "Cluster ID"
      requires :user_id, type: String, desc: "User ID"
    end
    put "/make_members/:id" do
      authorize_admin!
      user    = User.find(params.user_id)
      cluster = Cluster.find params[:cluster_id]
      user.add_me_to_cluster! cluster if cluster
      present :user, user, with: Api::V1::ValidToken::Entities::User
    end
  end
end
