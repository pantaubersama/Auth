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
      challenge.twitter_uid = params.invitation_id if params.type == "twitter"
      challenge.user_id = params.invitation_id if params.type == "user"
      challenge.invite_code = params.invite_code

      s = challenge.save!

      present :status, s
      present :challenge, challenge, with: API::V1::Challenges::Entities::Challenge
    end
  end

end