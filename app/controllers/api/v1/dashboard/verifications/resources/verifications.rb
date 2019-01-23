class API::V1::Dashboard::Verifications::Resources::Verifications < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams
  resources 'verifications' do
    before do
      authorize_admin!
    end

    desc "show user verification" do
      headers AUTHORIZATION_HEADERS
      detail "show user verification"
    end
    oauth2
    params do
      requires :id, type: String, desc: "User ID"
    end

    get '/show' do
      verification = Verification.where(user_id: params.id)
      present verification, with: API::V1::Dashboard::Verifications::Entities::Verification
    end


  end
end
