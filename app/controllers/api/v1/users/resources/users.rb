class Api::V1::Users::Resources::Users < API::V1::InternalResource
  helpers API::V1::Helpers
  

  resource "users" do
    desc 'Find', headers: INTERNAL_API_HEADERS
    params do
      requires :id, type: String
    end
    internal
    get "/:id" do
      present :user, User.find(params[:id]), with: Api::V1::Me::Entities::UserSimple
    end

    desc 'Where', headers: INTERNAL_API_HEADERS
    paginate per_page: 50, max_per_page: 500
    internal
    params do
      optional :ids, type: String, desc: "string of ID separate by comma"
    end
    get "/" do
      results = User.order("created_at desc")
      results = results.where(id: params.ids.split(",").map(&:strip)) if params.ids 
      resources = paginate(results)
      present :users, resources, with: Api::V1::Me::Entities::UserSimple
      present_metas resources
    end
  end
end
