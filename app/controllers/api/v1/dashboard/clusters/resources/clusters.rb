class API::V1::Dashboard::Clusters::Resources::Clusters < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  before do
    authorize_admin!
  end

  resource "clusters" do
    desc 'List, search, and filter' do
      detail "List, search, and filter"
      headers AUTHORIZATION_HEADERS
    end
    paginate per_page: 50, max_per_page: 500
    params do
      optional :q, type: String, desc: "Keyword"
      use :filter, filter_by: ["", "category_id"]
      optional :status, type: String, values: ["", "requested", "approved", "rejected"]
    end
    oauth2
    get "/" do
      query = "*"
      if params.q.present?
        query = "#{params.q}"
      end
      build_conditions = params.filter_by.present? && params.filter_value.present? ? { params.filter_by => params.filter_value } : {}
      build_conditions = params.status.present? ? build_conditions.merge({status: params.status})  : build_conditions
      resources        = ::Cluster.visible.search(query, match: :text_middle, misspellings: false, load: true, page: params.page, per_page: params.per_page, order: { name: :desc }, where: build_conditions).results
      present :clusters, resources, with: API::V1::Clusters::Entities::ClusterDetail
      present_metas resources
    end

    desc 'Approve cluster request' do
      headers AUTHORIZATION_HEADERS
      detail "Approve cluster request"
    end
    oauth2
    params do
      requires :id, type: String, desc: "Cluster ID"
    end
    post "/approve/:id" do
      cluster = ::Cluster.find params.id
      error!("Cluster sudah di set `tidak di setujui` (Rejected)", 403) if cluster.rejected?
      cluster.approve!
      present :cluster, cluster, with: API::V1::Clusters::Entities::ClusterDetail
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
      cluster = ::Cluster.find params.id
      error!("Cluster sudah di setujui (Approved)", 403) if cluster.approved?
      cluster.reject!
      present :cluster, cluster, with: API::V1::Clusters::Entities::ClusterDetail
    end

    desc 'Make user as member cluster' do
      headers AUTHORIZATION_HEADERS
      detail "Make user as member cluster"
    end
    oauth2
    params do
      requires :id, type: String, desc: "Cluster ID"
      requires :user_id, type: String, desc: "User ID"
    end
    put "/make_members/:id" do
      user    = User.find(params.user_id)
      cluster = Cluster.find params.id
      user.add_me_to_cluster! cluster if cluster
      present :user, user, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Remove user from cluster' do
      headers AUTHORIZATION_HEADERS
      detail "Remove user from cluster"
    end
    oauth2
    params do
      requires :id, type: String, desc: "Cluster ID"
      requires :user_id, type: String, desc: "User ID"
    end
    delete "/remove_members/:id" do
      user    = User.find(params.user_id)
      cluster = Cluster.find params.id

      user.quit_cluster! if user.has_role?(MODERATOR, cluster) || user.has_role?(MEMBER, cluster)
      present :user, user, with: Api::V1::ValidToken::Entities::User
    end

  end
end
