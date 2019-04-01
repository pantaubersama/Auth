require 'rails_helper'

RSpec.describe "API::V1::Challenge::Accept", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
  let!(:token2) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user2.id }
  let!(:challenge) { FactoryBot.create :wordstadium_challenge, invite_code: "ABC", twitter_uid: "38895958" }
  let!(:challenge2) { FactoryBot.create :wordstadium_challenge, invite_code: "ABCD", twitter_uid: "125029061" }
  let!(:challenge3) { FactoryBot.create :wordstadium_challenge, invite_code: "ABCDE", user_id: user.id }
  let!(:challenge4) { FactoryBot.create :wordstadium_challenge, invite_code: "ABCDEF", user_id: user2.id }

  before do
    stub_twitter_request "YOUR_TOKEN", "YOUR_SECRET"
  end

  # /v1/challenges/direct/invite
  describe "Accept" do
    context "[twitter] failed" do
      it "not connected to twitter" do
        accept_challenge "ABC", token.token
        expect(response.status).to eq(422)
      end

      it "using different twitter account" do
        connect_twitter token.token
        accept_challenge "ABCD", token.token
        expect(response.status).to eq(422)
      end

      it "was already accepted" do
        stub_accept_failed token.token, "ABC"

        connect_twitter token.token
        accept_challenge "ABC", token.token
        accept_challenge "ABC", token.token
        expect(response.status).to eq(422)
      end
    end

    context "[twitter] success" do
      it "accepted" do
        stub_accept_success token.token, "ABC"

        connect_twitter token.token
        accept_challenge "ABC", token.token
        expect(response.status).to eq(201)
        expect(json_response[:data][:status]).to eq(true)
        expect(json_response[:data][:challenge][:invite_code]).to eq(nil)
      end
    end

    context "[user] failed" do
      it "using different twitter account" do
        accept_challenge "ABCDEF", token.token
        expect(response.status).to eq(422)
      end

      it "was already accepted" do
        stub_accept_failed token.token, "ABCDEF"

        accept_challenge "ABCDEF", token.token
        accept_challenge "ABCDEF", token.token
        expect(response.status).to eq(422)
      end
    end

    context "[user] success" do
      it "accepted" do
        stub_accept_success token2.token, "ABCDEF"
        accept_challenge "ABCDEF", token2.token

        expect(response.status).to eq(201)
        expect(json_response[:data][:status]).to eq(true)
        expect(json_response[:data][:challenge][:invite_code]).to eq(nil)
      end
    end
  end

  def connect_twitter t
    post "/v1/accounts/connect", headers: {Authorization: t},
      params: {
        account_type: "twitter",
        oauth_access_token: 'YOUR_TOKEN',
        oauth_access_token_secret: 'YOUR_SECRET',
      }
  end

  def accept_challenge invite_code, token
    post "/v1/challenges/direct/accept", params: { invite_code: invite_code }, headers: {Authorization: token}
  end

end