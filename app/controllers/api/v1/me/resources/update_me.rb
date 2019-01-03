class Api::V1::Me::Resources::UpdateMe < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "me" do

    desc 'Update detail' do
      detail "Update detail"
      params Api::V1::Me::Entities::UserUpdate.documentation
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    put "/" do
      response = current_user.update_attributes!(update_params)
      present :user, current_user, with: Api::V1::Me::Entities::User
    end 

    desc 'Update username' do
      detail "Update username"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :username, type: String, description: "Username (without @)"
    end
    oauth2
    put "/username" do
      response = current_user.update_attributes!({username: params[:username]})
      present :user, current_user, with: Api::V1::Me::Entities::User
    end
    
    desc 'Update avatar' do
      detail "Update avatar"
      headers AUTHORIZATION_HEADERS
      params Api::V1::Me::Entities::UserAvatar.documentation
    end
    oauth2
    put "/avatar" do
      params[:avatar] = prepare_file(params[:avatar]) if params[:avatar].present?
      response = current_user.update_attribute(:avatar, params[:avatar])
      present :user, current_user, with: Api::V1::Me::Entities::User
    end

    desc 'Update vote preference' do
      detail "Update vote preference"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :vote_preference, type: Integer, values: [1, 2, 3], desc: "1 => Paslon 1 <br> 2 =>  Paslon 2 <br> 3 => Golput"
    end
    oauth2
    put "/vote_preference" do
      response = current_user.update_attributes(vote_preference_params)
      present :user, current_user, with: Api::V1::Me::Entities::User
    end

  end

  # permitted params
  helpers do
    def update_params
      permitted_params(params.except(:access_token)).permit(:full_name, :username, :about, :location, :organization, :education, :occupation, :vote_preference)
    end

    def vote_preference_params
      permitted_params(params.except(:access_token)).permit(:vote_preference)
    end
  end

end
