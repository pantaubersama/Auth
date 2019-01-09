require 'rails_helper'

RSpec.describe TwitterApi::Main, type: :model do
  before do
    @api = TwitterApi::Main.new "YOUR_TOKEN", "YOUR_SECRET"
    stub_twitter_request "YOUR_TOKEN", "YOUR_SECRET"
    stub_twitter_request_invalidate "YOUR_TOKEN", "YOUR_SECRET"
  end

  describe "Twitter Api valid ?" do
    it "is valid" do
      x = @api.valid?
      expect(x).to eq(true)
    end
  end

  describe "invalidate" do
    it "success" do
      x = @api.invalidate "YOUR_TOKEN"
      expect(x[:access_token]).to eq("YOUR_TOKEN")
    end
  end

end