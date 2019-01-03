class API::V1::Dashboard::Clusters::Resources::Clusters < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "clusters" do
    desc 'Approve cluster request' do
      detail "Approve cluster request"
    end
    params do
      requires :id, type: String, desc: "Cluster ID"
    end
    post "/approve/:id" do
      c = ::Cluster.find params.id
      c.approve!
      present :cluster, true
    end
  end
end
