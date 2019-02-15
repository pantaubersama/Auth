class API::V1::Dashboard::Users::Resources::UsersClusters < API::V1::ApplicationResource
    helpers API::V1::Helpers
    helpers API::V1::SharedParams
  
    resource "users_clusters" do
      before do
        authorize_admin!
      end

      desc 'List, Where' do
        detail "List, Where"
        headers AUTHORIZATION_HEADERS
      end
      paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
      params do
        optional :ids, type: String, desc: "string of ID separate by comma"
        use :searchkick_search, default_m: "word_start", default_o: "and"
        use :filter_no_value, filter_by: ["", "verified_true", "verified_false", "verified_all"]
        optional :cluster_id, type: String, desc: "Cluster ID"
        optional :cluster_name, type: String, desc: "Cluster name"
        optional :full_name, type: String, desc: "User name"
        optional :email, type: String, desc: "User Email"
      end
      oauth2
      get "/" do
        q = params.q.nil? || params.q.empty? ? "*" : params.q
        operator = params.o.nil? || params.o.empty? ? "and" : params.o
        match_word = params.m.nil? || params.m.empty? ? "word_start" : params.m.to_sym
  
        default_order = {created_at: {order: :desc, unmapped_type: "long"}}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => { order: params.direction.to_sym, unmapped_type: "long"  } } : default_order
  
        default_conditions = {cluster: {not: nil}}
        build_conditions = params.filter_by.present? ? user_filter(params.filter_by) : default_conditions
        build_conditions = build_conditions.merge({id: params.ids.split(",").map(&:strip)}) if params.ids.present?
        build_conditions = build_conditions.merge({"cluster.id" => params.cluster_id}) if params.cluster_id.present?
        build_conditions = build_conditions.merge({"cluster.name" => params.cluster_name}) if params.cluster_name.present?
        build_conditions = build_conditions.merge({"full_name" => params.full_name}) if params.full_name.present?
        build_conditions = build_conditions.merge({"email" => params.email}) if params.email.present?
        
        resources = User.search(q, 
          operator: operator, 
          match: match_word, 
          misspellings: false,
          load: false, 
          page: (params.page || 1), 
          per_page: (params.per_page || Pagy::VARS[:items]),
          order: build_order, 
          where: build_conditions
        )
        
        present :users, resources, with: Api::V1::Me::Entities::UserSimple
        present_metas_searchkick resources
      end

    end
  
  end
