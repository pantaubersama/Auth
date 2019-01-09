require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) { FactoryBot.create(:user) }

  before do
    stub_twitter_request "token1", "secret1"
    stub_twitter_request "token2", "secret2"
  end

  describe "Twitter" do
    it "connect" do
      account = Account.connect! user.id, :twitter, "token1", "secret1"
      expect(account.user_id).to  eq(user.id)
      expect(account.account_type).to  eq("twitter")
      expect(account.access_token).to  eq("token1")
      expect(account.access_token_secret).to  eq("secret1")
      expect(user.accounts.twitter.size).to  eq(1)

      account = Account.connect! user.id, :twitter, "token2", "secret2"
      expect(account.user_id).to  eq(user.id)
      expect(account.account_type).to  eq("twitter")
      expect(account.access_token).to  eq("token2")
      expect(account.access_token_secret).to  eq("secret2")
      expect(user.accounts.twitter.size).to  eq(1)

      expect(user.accounts.size).to  eq(1)
      expect(user.twitter?).to  eq(true)
    end
  end

  describe "Facebook" do
    it "connect" do
      account = Account.connect! user.id, :facebook, "token1", "secret1"
      expect(account.user_id).to  eq(user.id)
      expect(account.account_type).to  eq("facebook")
      expect(account.access_token).to  eq("token1")
      expect(user.accounts.facebook.size).to  eq(1)

      account = Account.connect! user.id, :facebook, "token2", "secret2"
      expect(account.user_id).to  eq(user.id)
      expect(account.account_type).to  eq("facebook")
      expect(account.access_token).to  eq("token2")
      expect(user.accounts.facebook.size).to  eq(1)

      expect(user.accounts.size).to  eq(1)
      expect(user.facebook?).to  eq(true)
    end
  end

  describe "Facebook + Twitter" do
    it "connect" do
      account = Account.connect! user.id, :facebook, "token1", "secret1"
      expect(account.user_id).to  eq(user.id)
      expect(account.account_type).to  eq("facebook")
      expect(account.access_token).to  eq("token1")
      expect(user.accounts.facebook.size).to  eq(1)

      account = Account.connect! user.id, :twitter, "token2", "secret2"
      expect(account.user_id).to  eq(user.id)
      expect(account.account_type).to  eq("twitter")
      expect(account.access_token).to  eq("token2")
      expect(account.access_token_secret).to  eq("secret2")
      expect(user.accounts.twitter.size).to  eq(1)

      expect(user.accounts.size).to  eq(2)
      expect(user.twitter?).to  eq(true)
      expect(user.facebook?).to  eq(true)
    end
  end

end
