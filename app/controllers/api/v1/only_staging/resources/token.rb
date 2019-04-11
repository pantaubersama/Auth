class Api::V1::OnlyStaging::Resources::Token < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "only_staging" do

    desc 'Make token expired' do
      detail "Make token expired"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/token" do
      d = Doorkeeper::AccessToken.find_by token: headers["Authorization"]
      d.expires_in = 1
      d.save!
      present d.expired?
    end

  end

end
