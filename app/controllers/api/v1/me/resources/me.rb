class Api::V1::Me::Resources::Me < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "me" do
    
    desc "It's me!" do
      detail "Return my profile"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/" do
      present :user, current_user, with: Api::V1::Me::Entities::User
    end

    desc "It's me! But simpler" do
      detail "Return simple profile"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/simple" do
      present :user, current_user, with: Api::V1::Me::Entities::UserSimple
    end

  end
end
