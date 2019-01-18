class API::V1::Callback::Resources::Invitation < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "callback" do
    desc "Invitation callback" do
      detail "Invitation callback"
    end
    params do
      requires :invite_code, type: String
    end
    post "/invitation" do
      u = User.find_by invite_code: params[:invite_code]

      result = u.update_attributes({invite_code: nil})
      cluster = Cluster.find u.tmp_cluster_id
      u.add_me_to_cluster! cluster

      present result
    end
  end
end