class API::V1::Examples::Resources::Examples < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "examples" do
    desc "Public" do
      detail "Public"
    end
    get "/public" do
      present :status, :public
      present :current_user, current_user
    end

    desc "Optional" do
      detail "Optional"
      headers OPTIONAL_AUTHORIZATION_HEADERS
    end
    get "/optional" do
      present :status, :optional
      present :current_user, current_user
    end
    
    desc "Protected" do
      detail "Protected"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/protected" do
      present :status, :protected
      present :current_user, current_user
    end
  end
end
