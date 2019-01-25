class Api::V1::Users::Resources::UsersPublic < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "users" do
    desc 'Find' do
      detail "Find"
    end
    params do
      requires :id, type: String
    end
    get "/:id/simple" do
      present :user, User.find(params[:id]), with: Api::V1::Me::Entities::UserSimple
    end

    desc 'List, Where' do
      detail "List, Where"
    end
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    params do
      optional :ids, type: String, desc: "string of ID separate by comma"
      use :searchkick_search, default_m: "word_start", default_o: "and"
      use :filter_no_value, filter_by: ["", "verified_true", "verified_false", "verified_all"]
      optional :email, type: String, desc: "Email"
      optional :cluster_name, type: String, desc: "Cluster name"
    end
    get "/" do
      q = params.q.nil? || params.q.empty? ? "*" : params.q
      operator = params.o.nil? || params.o.empty? ? "and" : params.o
      match_word = params.m.nil? || params.m.empty? ? "word_start" : params.m.to_sym

      default_order = {created_at: {order: :desc, unmapped_type: "long"}}
      build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => { order: params.direction.to_sym, unmapped_type: "long"  } } : default_order

      default_conditions = {}
      build_conditions = params.filter_by.present? ? user_filter(params.filter_by) : default_conditions
      build_conditions = build_conditions.merge({id: params.ids.split(",").map(&:strip)}) if params.ids.present?
      build_conditions = build_conditions.merge({email: params.email}) if params.email.present?
      build_conditions = build_conditions.merge({"cluster.name" => params.cluster_name}) if params.cluster_name.present?

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