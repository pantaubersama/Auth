class API::V1::Callback::Resources::AccessToken < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "callback" do
    desc "Callback to exchange provider token / grant code to access token"
    params do
      optional :code, type: String, documentation: {desc: "Callback using code"}
      optional :provider_token, type: String, documentation: {desc: "Callback using symbolic token"}
      optional :firebase_key, type: String, documentation: {desc: "Firebase key"}
      optional :firebase_key_type, type: String, values: ["android", "ios", "web"], documentation: {desc: "Firebase key type"}
    end
    get "/" do
      token = params[:provider_token]
      token = HTTParty.post(ENV["SYMBOLIC_URL"] + "/oauth/token", {
          query: {
            grant_type: "authorization_code",
            redirect_uri: ENV["CALLBACK_URL"],
            client_id: ENV["APP_ID"],
            client_secret: ENV["APP_SECRET"],
            code: params[:code]
          }
        }).parsed_response["access_token"] if params[:code]

        api = Ruby::Identitas::Main.new(token)
        request = api.me
        verify = api.verify_credential

        unless verify && verify["credentials"]["application_id"] == ENV["APP_ID"]
          error!("Token is invalid. Check your APP_ID", 400)
        end
        
        if request.response.code.to_i == 200
          response = JSON.parse request.body
          response_obj = Hashie::Mash.new response
          user = User.from_omniauth(response_obj)
          
          access_token = user.generate_access_token

          if params.firebase_key.present? && params.firebase_key_type.present?
            FirebaseKey.assign! user.id, params.firebase_key_type, params.firebase_key
          end

          present access_token, with: Api::V1::Callback::Entities::AccessToken
        else
          error!("Token is invalid", 400)
        end
    end

  end
end
