module API::V1::Badges::Resources
  class BadgesInternal < API::V1::InternalResource
    helpers API::V1::Helpers

    # internal
    resource "badges" do
      desc '[Internal API] Create' do
        detail "[Internal API] Create"
        headers INTERNAL_API_HEADERS
      end
      internal
      params do
        requires :name, type: String, desc: "Name"
        requires :description, type: String, desc: "Description"
        requires :image, type: File, desc: "Image"
        requires :position, type: Integer, desc: "Position"
      end
      post "/" do
        params[:image] = prepare_file(params[:image]) if params[:image].present?
        b = ::Badge.create badges_params
        present :badge, b, with: API::V1::Badges::Entities::Badge
      end
    end

    # permitted params
    helpers do
      def badges_params
        permitted_params(params.except(:access_token)).permit(:name, :description, :image, :position)
      end
    end

  end
end