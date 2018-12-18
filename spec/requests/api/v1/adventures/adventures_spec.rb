require 'rails_helper'

RSpec.describe "Api::V1::Adventures", type: :request do
  describe "[GET] Endpoint /version" do
    it "should returns 200 with valid params when success" do
      get "/v1/adventures/version"
      expect(json_response[:data]).to eq({ "version" => "v1" })
      expect(response.status).to eq(200)
    end
  end
  describe "[GET] Endpoint /" do
    it "should returns 200 with valid params when success all" do
      get "/v1/adventures"
      expect(json_response[:data][:adventures]).to eq([
                                                          { "id" => 1, "title" => "Hello World" },
                                                          { "id" => 2, "title" => "Hello World 2" },
                                                          { "id" => 3, "title" => "Hello World 3" }
                                                      ])
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 25, "total" => 1 } })
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success using pagination (1)" do
      get "/v1/adventures", params: { page: 1, per_page: 1 }
      expect(json_response[:data][:adventures]).to eq([
                                                          { "id" => 1, "title" => "Hello World" }
                                                      ])
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 1, "total" => 3 } })
      expect(response.status).to eq(200)
    end
    it "should returns 200 with valid params when success using pagination (2)" do
      get "/v1/adventures", params: { page: 1, per_page: 2 }
      expect(json_response[:data][:adventures]).to eq([
                                                          { "id" => 1, "title" => "Hello World" },
                                                          { "id" => 2, "title" => "Hello World 2" }
                                                      ])
      expect(json_response[:data][:meta]).to eq({ "pages" => { "page" => 1, "per_page" => 2, "total" => 2 } })
      expect(response.status).to eq(200)
    end
  end
  describe "[GET] Endpoint /show" do
    it "should returns 200 with valid params when success" do
      get "/v1/adventures/show", params: { id: 1 }
      expect(json_response[:data]).to eq({ "adventure" => { "id" => 1, "title" => "Hello World" } })
      expect(response.status).to eq(200)
    end
  end
  describe "[POST] Endpoint /" do
    it "should returns 201 with valid params when success" do
      post "/v1/adventures", params: { title: "Welcome to the Jungle" }
      expect(json_response[:data]).to eq({ "adventure" => { "id" => 4, "title" => "Welcome to the Jungle" } })
      expect(response.status).to eq(201)
    end
  end
  describe "[PUT] Endpoint /" do
    it "should returns 201 with valid params when success" do
      put "/v1/adventures", params: { id: 2, title: "Welcome to the Home" }
      expect(json_response[:data]).to eq({ "adventure" => { "id" => 2, "title" => "Welcome to the Home" } })
      expect(response.status).to eq(200)
    end
  end
  describe "[DELETE] Endpoint /" do
    it "should returns 201 when success" do
      delete "/v1/adventures", params: { id: 2 }
      expect(json_response[:data]).to eq("success deleted data with id 2")
      expect(response.status).to eq(200)
    end
  end
end