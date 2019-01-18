class API::V1::Dashboard::Categories::Resources::Categories < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "categories" do

    desc "Update category" do
      detail "Update category"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String
      optional :description, type: String
    end
    oauth2
    put "/:id" do
      q = Category.find params.id
      error! "Not found" unless q.present?
      status = q.update_attributes!(category_params)
      present :status, status
      present :category, q, with: API::V1::Dashboard::Categories::Entities::Category
    end

    desc "Delete category" do
      detail "Delete category"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/:id" do
      q = Category.find params.id
      error! "Not found" unless q.present?
      status = q.destroy!
      present :status, status.destroyed?
      present :category, q, with: API::V1::Dashboard::Categories::Entities::Category
    end

    desc "Detail category" do
      detail "Detail category"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id" do
      q = Category.find params.id
      error! "Not found" unless q.present?
      present :category, q, with: API::V1::Dashboard::Categories::Entities::Category
    end

  end

  helpers do
    def category_params
      permitted_params(params.except(:access_token)).permit(:name, :description)
    end
  end

end
