require 'rails_helper'

RSpec.describe "Api::V1::Callback", type: :request do
  describe "Success callback" do
    it "generate client token" do
      get "/v1/callback/optional", headers: {Authorization: token.token}
    end
  end
end