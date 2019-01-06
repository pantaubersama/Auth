class API::V1::Clusters::Resources::Moderations < API::V1::ApplicationResource
  helpers API::V1::Helpers
  helpers API::V1::SharedParams

  namespace "me" do
    desc "Quit cluster" do
      detail "Quit cluster"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    delete "/clusters" do
      cluster = current_user.cluster
      present :status, current_user.quit_cluster!
      present :cluster, cluster, with: API::V1::Clusters::Entities::Cluster
    end
  end

  resource "clusters" do

    desc "Enable magic link" do
      detail "Enable / disable"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :enable, type: Boolean
    end
    oauth2
    post "/:id/magic_link" do
      c = ::Cluster.visible.find params.id
      
      authorize_moderator! c

      c.update_attribute :is_link_active, params.enable
      present :cluster, c, with: API::V1::Clusters::Entities::ClusterDetail 
    end

    desc "Join cluster" do
      detail "Join cluster using magic link"
      headers AUTHORIZATION_HEADERS
    end
    params do
      requires :magic_link, type: String
    end
    oauth2
    get "join" do
      c = ::Cluster.visible.find_by magic_link: params.magic_link
      
      error! "Magic link disabled", 403 unless c.is_link_active

      current_user.add_me_to_cluster! c
      c.increase_referal
      present :cluster, c, with: API::V1::Clusters::Entities::ClusterDetail 
    end
    
  end

end