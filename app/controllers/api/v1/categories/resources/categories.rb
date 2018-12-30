class API::V1::Categories::Resources::Categories< API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "categories" do

    desc 'Find' do
      detail "Find"
    end
    params do
      requires :id, type: String
    end
    get "/:id" do
      present :category, ::Category.find(params[:id]), with: API::V1::Categories::Entities::Category
    end

    desc 'Where' do
      detail "Where"
    end
    paginate per_page: 50, max_per_page: 500
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

end
