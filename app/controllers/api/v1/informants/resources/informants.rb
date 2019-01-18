class API::V1::Informants::Resources::Informants < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "me" do
    desc 'My extra information' do
      detail "My extra information (informant)"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/informants" do
      present :informant, current_user.informant, with: API::V1::Informants::Entities::Informant
    end 
  end

  resource "informants" do
    desc 'Update informant' do
      detail "Update informant"
      headers AUTHORIZATION_HEADERS
      params API::V1::Informants::Entities::Informant.documentation
    end
    oauth2
    put "/" do
      response = current_user.informant.update_attributes(informant_params)
      present :informant, current_user.informant, with: API::V1::Informants::Entities::Informant
    end 
  end

  # permitted params
  helpers do
    def informant_params
      permitted_params(params.except(:access_token)).permit(:identity_number, :pob, :dob, :gender, :occupation, :nationality, :address, :phone_number)
    end
  end


end