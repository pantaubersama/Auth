class API::V1::Dashboard::PoliticalParties::Resources::PoliticalParties < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "political_parties" do

    desc "Update political party" do
      detail "Update political party"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :name, type: String, desc: "Name"
      optional :image, type: File, desc: "Image"
    end
    oauth2
    put "/:id" do
      params[:image] = prepare_file(params[:image]) if params[:image].present?
      q = PoliticalParty.find params.id
      error! "Not found" unless q.present?
      status = q.update_attributes!(political_party_params)
      present :status, status
      present :political_party, q, with: API::V1::PoliticalParties::Entities::PoliticalParty
    end

    desc "Show political party" do
      detail "Show political party"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/:id" do
      q = PoliticalParty.find params.id
      error! "Not found" unless q.present?
      present :political_party, q, with: API::V1::PoliticalParties::Entities::PoliticalParty
    end

    desc "Delete political party" do
      detail "Delete political party"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/:id" do
      q = PoliticalParty.find params.id
      error! "Not found" unless q.present?
      status = q.destroy!
      present :status, status.destroyed?
      present :political_party, q, with: API::V1::PoliticalParties::Entities::PoliticalParty
    end

    desc "Create badge" do
      detail "Create badge"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :name, type: String, desc: "Name"
      optional :image, type: File, desc: "Image"
    end
    oauth2
    post "/" do
      q = PoliticalParty.new political_party_params
      status = q.save!
      present :status, status
      present :political_party, q, with: API::V1::PoliticalParties::Entities::PoliticalParty
    end

  end

  # permitted params
  helpers do
    def political_party_params
      permitted_params(params.except(:access_token)).permit(:name, :image)
    end
  end

end
