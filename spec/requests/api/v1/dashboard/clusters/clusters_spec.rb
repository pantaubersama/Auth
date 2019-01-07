require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::Clusters", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    @category = FactoryBot.create :category
    @cluster  = create :cluster, requester: user, is_displayed: false, status: :requested, category: @c
    expect(@cluster.is_displayed).to eq(false)
    user.make_me_admin!
  end

  describe "[GET] Endpoint /dashboard/v1/clusters/approve" do
    it "should returns 201 with valid params when success" do
      post "/dashboard/v1/clusters/approve/#{ @cluster.id}",
           params:  {
             id: @cluster.id,
           },
           headers: { Authorization: token.token }

      expect(json_response[:data][:cluster][:is_displayed]).to eq(true)
      expect(response.status).to eq(201)
    end
  end

end