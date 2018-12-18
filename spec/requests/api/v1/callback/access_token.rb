require 'rails_helper'

RSpec.describe "Api::V1::Callback", type: :request do
  describe "[GET] Endpoint /auth/v1/callback" do
    it "should returns 500 if no params" do
      get "/auth/v1/callback"
      expect(response.status).to eq(500)
    end
  end

  describe "[GET] Endpoint /auth/v1/callback" do
    it "should returns 200 when token /code is corret" do
      # get "/auth/v1/callback"
      # expect(response.status).to eq(500)
    end
  end
end