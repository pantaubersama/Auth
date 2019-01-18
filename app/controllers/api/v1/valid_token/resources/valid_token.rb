class API::V1::ValidToken::Resources::ValidToken < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "valid_token" do
    desc 'Check token validity', headers: AUTHORIZATION_HEADERS
    oauth2
    get "/verify" do
      present :info, current_user, with: Api::V1::ValidToken::Entities::User
      present :credential, doorkeeper_token, with: Api::V1::Callback::Entities::AccessToken, access_token: params[:access_token]
    end
  end
end
