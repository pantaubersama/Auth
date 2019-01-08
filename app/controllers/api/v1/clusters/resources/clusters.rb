class API::V1::Clusters::Resources::Clusters < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "clusters" do

    desc 'Request' do
      detail "Request cluster. Requester automatically become Admin when approved"
      headers AUTHORIZATION_HEADERS
      params API::V1::Clusters::Entities::Cluster.documentation
    end
    oauth2
    post "/" do
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      b              = ::Cluster.create cluster_params
      b.update_attribute(:requester, current_user)
      present :cluster, b, with: API::V1::Clusters::Entities::ClusterDetail
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
      use :filter, filter_by: ["", "category_id"]
    end
    get "/" do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      build_conditions = params.filter_by.present? && params.filter_value.present? ? { params.filter_by => params.filter_value } : {}
      resources        = ::Cluster.visible.search(query, match: :text_middle, misspellings: false, load: true, page: params.page, per_page: params.per_page, order: { name: :desc }, where: build_conditions).results
      present :clusters, resources, with: API::V1::Clusters::Entities::ClusterDetail
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