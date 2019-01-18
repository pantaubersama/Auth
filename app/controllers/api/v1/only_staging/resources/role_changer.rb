class API::V1::OnlyStaging::Resources::RoleChanger < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "only_staging" do
    desc '10 cluster example' do
      detail "10 cluster example"
    end
    get "/cluster_list" do
      present :clusters, Cluster.limit(10)
    end

    desc 'Make me admin' do
      headers AUTHORIZATION_HEADERS
      detail "Make me admin"
    end
    oauth2
    post "/make_me_admin" do
      current_user.make_me_admin!
      present :user, current_user, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Remove all of my roles' do
      headers AUTHORIZATION_HEADERS
      detail "Remove all of my roles"
    end
    oauth2
    delete "/remove_roles" do
      current_user.roles.delete_all
      present :user, current_user, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Make me moderator' do
      headers AUTHORIZATION_HEADERS
      detail "Make me moderator"
    end
    params do
      requires :cluster_id
    end
    oauth2
    post "/make_me_moderator" do
      cluster = Cluster.find params[:cluster_id]
      current_user.make_me_moderator! cluster if cluster
      present :user, current_user, with: Api::V1::ValidToken::Entities::User
    end

    desc 'Make me member' do
      headers AUTHORIZATION_HEADERS 
      detail "Make me member"
    end
    params do
      requires :cluster_id
    end
    oauth2
    post "/make_me_member" do
      cluster = Cluster.find params[:cluster_id]
      current_user.add_me_to_cluster! cluster if cluster
      present :user, current_user, with: Api::V1::ValidToken::Entities::User
    end

  end
end
