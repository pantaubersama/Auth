class Api::V1::Me::Resources::Password < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "me" do

    desc 'Change password' do
      detail "Change password. This is a wrapper to change Symbolic Password"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :password, type: String, desc: 'New password'
      requires :password_confirmation, type: String, desc: 'Password confirmation'
    end
    oauth2
    post "/password" do
      api = Ruby::Identitas::Main.new("", ENV["AUTH_KEY"])
      resp = api.user_password({id: current_user.uid, password: params[:password], password_confirmation: params[:password_confirmation]})
      present :status, resp.parsed_response
    end

  end

end
