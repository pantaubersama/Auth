class API::V1::Dashboard::Users::Resources::Users < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "users" do
    before do
      authorize_admin!
    end

    desc 'Make admin' do
      headers AUTHORIZATION_HEADERS
      detail "Make admin"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end
    post "/admin" do
      u = User.find params.id
      u.make_me_admin!
      u.reindex
      present :user, u, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Remove admin' do
      headers AUTHORIZATION_HEADERS
      detail "Remove admin"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end
    delete "/admin" do
      u = User.find params.id
      u.remove_admin!
      u.reindex
      present :user, u, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Approve verification' do
      headers AUTHORIZATION_HEADERS
      detail "Approve verification"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end
    post "/approve" do
      u = User.find params.id
      u.verification.verified!
      u.reindex
      present :user, u, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Reject verification' do
      headers AUTHORIZATION_HEADERS
      detail "Reject verification"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end
    delete "/reject" do
      u = User.find params.id
      u.verification.rejected!
      u.reindex
      present :user, u, with: Api::V1::ValidToken::Entities::User
    end

    desc 'list user verification' do
      headers AUTHORIZATION_HEADERS
      detail "list user verification"
    end
    oauth2
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    params do
      optional :ids, type: String, desc: "string of ID separate by comma"
      optional :email, type: String, desc: "Email"
      use :searchkick_search, default_m: "word_start", default_o: "and"
      optional :status, type: String, values: ["", "requested", "verified", "rejected"]
    end
    get "/verifications" do
      q = params.q.nil? || params.q.empty? ? "*" : params.q
      operator = params.o.nil? || params.o.empty? ? "and" : params.o
      match_word = params.m.nil? || params.m.empty? ? "word_start" : params.m.to_sym

      default_order = {created_at: :desc}
      build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order

      default_conditions = {}
      build_conditions = params.status.present? ? {status_verification: params.status}  : default_conditions
      build_conditions = build_conditions.merge({id: params.ids.split(",").map(&:strip)}) if params.ids.present?
      build_conditions = build_conditions.merge({email: params.email }) if params.email.present?

      resources = User.search(q,
        operator: operator,
        match: match_word,
        misspellings: false,
        load: false,
        page: (params.page || 1),
        per_page: (params.per_page || Pagy::VARS[:items]),
        order: build_order,
        where: build_conditions,
        fields: [:full_name, :about, :email]
      )

      present :users, resources, with: Api::V1::Dashboard::Verifications::Entities::User
      present_metas_searchkick resources
    end


    desc 'update user detail' do
      detail "Update detail"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
      optional :full_name, type: String, desc: "Full Name"
      optional :username, type: String, desc: "Username (without @)"
      optional :about, type: String, desc: "About"
      optional :location, type: String, desc: "Location"
      optional :education, type: String, desc: "Education"
      optional :occupation, type: String, desc: "Occupation"
    end
    put '/update_detail' do
      user = User.find(params.id)
      user.update(update_detail_params)
      present :user, user, with: Api::V1::Me::Entities::User
    end

    desc 'Update user informant' do
      detail "Update user informant"
      headers AUTHORIZATION_HEADERS
      params API::V1::Informants::Entities::Informant.documentation
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end
    put "/update_informant" do
      user = User.find(params.id)
      response = user.informant.update_attributes(informant_params)
      present :informant, user.informant, with: API::V1::Informants::Entities::Informant
    end

    desc 'Update avatar' do
      detail "Update avatar"
      headers AUTHORIZATION_HEADERS
      params Api::V1::Me::Entities::UserAvatar.documentation
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end
    put "/avatar" do
      params[:avatar] = prepare_file(params[:avatar]) if params[:avatar].present?
      user = User.find(params.id)
      response        = user.update_attribute(:avatar, params[:avatar])
      present :user, user, with: Api::V1::Me::Entities::User
    end
  end

  # permitted params
  helpers do
    def update_detail_params
      permitted_params(params.except(:access_token)).permit(:full_name, :username, :about, :location, :education, :occupation)
    end

    def informant_params
      permitted_params(params.except(:access_token)).permit(:identity_number, :pob, :dob, :gender, :occupation, :nationality, :address, :phone_number)
    end
  end
end
