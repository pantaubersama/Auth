class API::V1::PoliticalParties::Resources::PoliticalParties < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  resource "political_parties" do

    desc 'List' do
      detail "List"
    end
    paginate per_page: 50, max_per_page: 500
    get "/" do
      parties = PoliticalParty.all
      resources = paginate(parties)
      present :political_parties, resources, with: API::V1::PoliticalParties::Entities::PoliticalParty
      present_metas resources
    end

  end

end