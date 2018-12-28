class API::V1::Clusters::Resources::Clusters < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "clusters" do

    desc 'Request' do
      detail "Request cluster. Requester automatically become Admin when approved"
      headers AUTHORIZATION_HEADERS
      params API::V1::Clusters::Entities::Cluster.documentation
    end
    oauth2
    post "/" do
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      b = ::Cluster.create cluster_params
      b.update_attribute(:requester, current_user)
      present :cluster, b, with: API::V1::Clusters::Entities::Cluster
    end

    desc "Display cluster" do
      detail "Display visible / approved cluster"
    end
    get "/:id" do
      c = ::Cluster.visible.find params[:id]
      present :cluster, c, with: API::V1::Clusters::Entities::ClusterSimple
    end

  end

  # permitted params
  helpers do
    def cluster_params
      permitted_params(params.except(:access_token)).permit(:name, :description, :image, :category_id)
    end
  end
end