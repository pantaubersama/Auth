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
    paginate per_page: Pagy::VARS[:items], max_per_page: Pagy::VARS[:max_per_page]
    params do
      optional :ids, type: String, desc: "string of ID separate by comma"
      optional :name, type: String, desc: "name"
    end
    get "/" do
      results = ::Category.order("created_at desc")
      results = results.where(id: params.ids.split(",").map(&:strip)) if params.ids
      results = results.where("lower(name) like ?", "%"+params.name.downcase+"%") if params.name
      resources = paginate(results)
      present :categories, resources, with: API::V1::Categories::Entities::Category
      present_metas resources
    end

    desc 'Create' do
      detail "Create"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      requires :name, type: String, desc: "Name"
      optional :description, type: String, desc: "Deskripsi"
    end
    post "/" do
      b = ::Category.new categories_params
      b.creator_id = current_user.id
      b.save!
      present :category, b, with: API::V1::Categories::Entities::Category
    end
  end

  helpers do
    def categories_params
      permitted_params(params.except(:access_token)).permit(:name, :description)
    end
  end

end
