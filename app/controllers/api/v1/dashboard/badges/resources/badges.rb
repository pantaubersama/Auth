class API::V1::Dashboard::Badges::Resources::Badges < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "badges" do

    desc "Update badge" do
      detail "Update badge"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String, desc: "Name"
      optional :description, type: String, desc: "Description"
      optional :image, type: File, desc: "Image"
      optional :position, type: Integer, desc: "Position"
    end
    oauth2
    put "/:id" do
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      q = Badge.find params.id
      error! "Not found" unless q.present?
      status = q.update_attributes!(badge_params)
      present :status, status
      present :badge, q, with: API::V1::Badges::Entities::Badge
    end

    desc "Delete badge" do
      detail "Delete badge"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/:id" do
      q = Badge.find params.id
      error! "Not found" unless q.present?
      status = q.destroy!
      present :status, status.paranoia_destroyed?
      present :badge, q, with: API::V1::Badges::Entities::Badge
    end

    desc "Create badge" do
      detail "Create badge"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String, desc: "Name"
      optional :description, type: String, desc: "Description"
      optional :image, type: File, desc: "Image"
      optional :position, type: Integer, desc: "Position"
    end
    oauth2
    post "/" do
      q = Badge.find params.id
      error! "Not found" unless q.present?
      present :badge, q, with: API::V1::Badges::Entities::Badge
    end

  end

  # permitted params
  helpers do
    def badge_params
      permitted_params(params.except(:access_token)).permit(:name, :description, :image, :position)
    end
  end

end
