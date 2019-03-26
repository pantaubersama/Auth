class API::V1::Challenges::Resources::Invite < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "challenges" do
    desc "Invite & save invite code" do
      detail "Invite & save invite code"
    end
    params do
      requires :invite_code, type: String, desc: "Your invite code"
      requires :invitation_id, type: String, desc: "Twitter ID | User ID"
      requires :type, type: String, values: ["twitter", "user"]
    end
    post "/direct/invite" do
      challenge = Wordstadium::Challenge.find_or_initialize_by invite_code: params.invite_code
      s = challenge.update_attributes! challenge_params
      present :status, s
      present :challenge, challenge, with: API::V1::Challenges::Entities::Challenge
    end
  end

  # permitted params
  helpers do
    def challenge_params
      permitted_params(params.except(:access_token)).permit(:invite_code, :invitation_id, :type)
    end
  end
end