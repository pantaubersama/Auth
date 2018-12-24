class Api::V1::Users::Resources::Users < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "users" do
    desc 'Get user detail', headers: AUTHORIZATION_HEADERS
    params do
      requires :id, type: String
    end
    oauth2
    get "/:id" do
      error!("You must provide client credential token (Confidential App)", 401) if doorkeeper_access_token.resource_owner_id.present?
      present User.find(params[:id]), with: Api::V1::Me::Entities::UserSimple
    end
  end
end
