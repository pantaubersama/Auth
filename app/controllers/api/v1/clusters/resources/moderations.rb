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

    desc "Invite to my cluster" do
      detail "Invite to my cluster"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    params do
      requires :emails, type: String, desc: "Email separated by comma"
    end
    post "invite" do
      c = current_user.cluster

      error! "Cluster not found", 404 unless c.present?
      authorize_moderator! c

      data_email = params.emails.split(",").map(&:strip)

      results = []

      # TODO : Optimize this !!
      data_email.each_with_index do |email, idx|
        invite_code = params.invite_code.present? ? (params.invite_code.to_s + "_" + idx.to_s) : SecureRandom.hex(5)

        u = ::User.find_or_create_by!(email: email) do |x|
          x.tmp_cluster_id = c.id
          x.invite_code = invite_code
        end

        not_in_cluster = Cluster.find_roles(:moderator, u).count == 0 && Cluster.find_roles(:member, u).count == 0 
        if not_in_cluster
          result = current_user.invite_to_symbolic u, u.invite_code

          status = u.update_attributes!({provider: result["provider"], uid: result["uid"]})

          results << {id: u.id, email: u.email, status: u.tmp_cluster_id}
        end
      end

      present results

    end
    
  end

end