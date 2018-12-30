class API::V1::Categories::Resources::CategoriesInternal < API::V1::InternalResource
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

  end

  # permitted params
  helpers do
    def categories_params
      permitted_params(params.except(:access_token)).permit(:name)
    end
  end
end
