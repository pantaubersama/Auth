class API::V1::SecureAdventures::Resources::SecureAdventures < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "secure_adventures" do
    desc "Version", headers: AUTHORIZATION_HEADERS
    oauth2
    get "version" do
      results = { version: "v1" }
      present results
    end

    desc "Get All", headers: AUTHORIZATION_HEADERS
    oauth2
    get "/" do
      results   = [{ id: 1, title: "Hello World" }, { id: 2, title: "Hello World 2" }, { id: 3, title: "Hello World 3" },]
      resources = paginate(results)
      present_metas resources
      present :adventures, resources, with: API::V1::Adventures::Entities::Adventure
    end
    
    desc "Get by id", headers: AUTHORIZATION_HEADERS
    params do
      requires :id, type: Integer
    end
    oauth2
    get "/show" do
      results = [{ id: 1, title: "Hello World" }, { id: 2, title: "Hello World 2" }, { id: 3, title: "Hello World 3" },]
      present :adventure, results[params.id - 1], with: API::V1::Adventures::Entities::Adventure
    end

    desc "Create", headers: AUTHORIZATION_HEADERS
    params do
      requires :title, type: String
    end
    oauth2
    post "/" do
      results = { id: 4, title: params.title }
      present :adventure, results, with: API::V1::Adventures::Entities::Adventure
    end

    desc "Update", headers: AUTHORIZATION_HEADERS
    params do
      requires :id, type: Integer
      requires :title, type: String
    end
    oauth2
    put "/" do
      error!("Can't find id #{params.id}", 422) unless [1, 2, 3].include?(params.id)
      results = { id: params.id, title: params.title }
      present :adventure, results, with: API::V1::Adventures::Entities::Adventure
    end

    desc "Delete", headers: AUTHORIZATION_HEADERS
    params do
      requires :id, type: Integer
    end
    oauth2
    delete "/" do
      error!("Can't find id #{params.id}", 422) unless [1, 2, 3].include?(params.id)

      present "success deleted data with id #{params.id}"
    end


  end
end
