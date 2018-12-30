class API::V1::Clusters::Resources::Clusters < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  namespace "me" do

    desc "Quit cluster" do
      detail "Quit cluster"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/clusters" do
      cluster = current_user.cluster
      present :status, current_user.quit_cluster!
      present :cluster, cluster, with: API::V1::Clusters::Entities::Cluster
    end
  end

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
      present :cluster, c, with: API::V1::Clusters::Entities::ClusterDetail
    end

    desc 'List, search, and filter' do
      detail "List, search, and filter"
    end
    paginate per_page: 50, max_per_page: 500
    params do
      optional :q, type: String, desc: "Keyword"
      use :filter, filter_by: %i(category_id)
    end
    get "/" do
      results = ::Cluster.visible.order("created_at desc")
      results = results.where("LOWER(name) like ? OR LOWER(description) like ?", "%"+params.q+"%", "%"+params.q+"%") if params.q.present?
      results = results.where(params.filter_by.to_sym => params.filter_value) if params.filter_by.present? && params.filter_value.present?
      resources = paginate(results)
      present :clusters, resources, with: API::V1::Clusters::Entities::Cluster
      present_metas resources
    end

  end

  # permitted params
  helpers do
    def cluster_params
      permitted_params(params.except(:access_token)).permit(:name, :description, :image, :category_id)
    end
  end
end