class Api::V1::Users::Resources::Users < API::V1::InternalResource
  helpers API::V1::Helpers

  resource "users" do
    desc '[Internal API] Find but return full data' do
      detail "[Internal API] Find but return full data"
      headers INTERNAL_API_HEADERS
    end
    params do
      requires :id, type: String
    end
    internal
    get "/:id/full" do
      present :user, User.find(params[:id]), with: Api::V1::Me::Entities::User
    end

    desc '[Internal API] Find' do
      detail "[Internal API] Find"
      headers INTERNAL_API_HEADERS
    end
    params do
      requires :id, type: String
    end
    internal
    get "/:id" do
      present :user, User.find(params[:id]), with: Api::V1::Me::Entities::User
    end

  end
end
