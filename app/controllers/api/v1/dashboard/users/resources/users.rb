class API::V1::Dashboard::Users::Resources::Users < API::V1::ApplicationResource
  helpers API::V1::Helpers

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
      present :user, u, with: Api::V1::ValidToken::Entities::User
    end

  end
end
