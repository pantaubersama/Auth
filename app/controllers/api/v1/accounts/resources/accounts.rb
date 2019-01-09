module API::V1::Accounts::Resources
  class Accounts < API::V1::ApplicationResource
    helpers API::V1::Helpers

    resource "accounts" do

      desc 'Connect' do
        detail "Connect"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :account_type, type: String, values: ["twitter", "facebook"]
        requires :oauth_access_token, type: String
        requires :oauth_access_token_secret, type: String
      end
      oauth2
      post "/connect" do
        a = Account.connect! current_user.id, params.account_type, params.oauth_access_token, params.oauth_access_token_secret
        present :account, a, with: API::V1::Accounts::Entities::Account
      end

      desc 'Disconnect' do
        detail "Disconnect"
        headers AUTHORIZATION_HEADERS
      end
      params do
        requires :account_type, type: String, values: ["twitter", "facebook"]
      end
      oauth2
      delete "/disconnect" do
        a = current_user.accounts.where(account_type: params.account_type.to_sym).first
        error! "Tidak ditemukan", 404 unless a.present?
        a.disconnect! params.account_type.to_sym
        present :account, a, with: API::V1::Accounts::Entities::Account
      end
      
    end

  end
end