class Api::V1::Me::Resources::UpdateMe < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "me" do
    
    desc 'Update detail' do
      detail "Update detail"
      params Api::V1::Me::Entities::UserUpdate.documentation
      headers AUTHORIZATION_HEADERS
    end
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
    put "/username" do
      response = current_user.update_attributes!({username: params[:username]})
      present :user, current_user, with: Api::V1::Me::Entities::User
    end
    
    desc 'Update avatar' do
      detail "Update avatar"
      headers AUTHORIZATION_HEADERS
      params Api::V1::Me::Entities::UserAvatar.documentation
    end
    put "/avatar" do
      params[:avatar] = prepare_file(params[:avatar]) if params[:avatar].present?
      response = current_user.update_attribute(:avatar, params[:avatar])
      present :user, current_user, with: Api::V1::Me::Entities::User
    end

  end

  # permitted params
  helpers do
    def update_params
      permitted_params(params.except(:access_token)).permit(:first_name, :last_name, :username, :about, :location, :organization, :education, :occupation)
    end
  end

end
