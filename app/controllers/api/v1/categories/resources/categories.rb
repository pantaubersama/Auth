class API::V1::Categories::Resources::Categories < API::V1::InternalResource
  helpers API::V1::Helpers
  

  resource "categories" do

    desc '[Internal API] Create' do
      detail "[Internal API] Create"
      headers INTERNAL_API_HEADERS
    end
    internal
    params do
      requires :name, type: String, desc: "Name"
    end
    post "/" do
      b = ::Category.create categories_params
      present :category, b, with: API::V1::Categories::Entities::Category
    end

    desc '[Internal API] Find' do
      detail "[Internal API] Find"
      headers INTERNAL_API_HEADERS
    end
    params do
      requires :id, type: String
    end
    internal
    get "/:id" do
      present :categopry, ::Category.find(params[:id]), with: API::V1::Categories::Entities::Category
    end

    desc '[Internal API] Where' do
      detail "[Internal API] Where"
      headers INTERNAL_API_HEADERS
    end
    paginate per_page: 50, max_per_page: 500
    internal
    params do
      optional :ids, type: String, desc: "string of ID separate by comma"
    end
    get "/" do
      results = ::Category.order("created_at desc")
      results = results.where(id: params.ids.split(",").map(&:strip)) if params.ids 
      resources = paginate(results)
      present :categories, resources, with: API::V1::Categories::Entities::Category
      present_metas resources
    end
  end

  # permitted params
  helpers do
    def categories_params
      permitted_params(params.except(:access_token)).permit(:name)
    end
  end
end
