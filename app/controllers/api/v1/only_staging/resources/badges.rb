class API::V1::OnlyStaging::Resources::Badges < API::V1::ApplicationResource
  helpers API::V1::Helpers

  namespace "only_staging" do
    desc 'Grant me a badge' do
      headers AUTHORIZATION_HEADERS
      detail "Grant me a badge"
    end
    oauth2
    params do
      requires :badge_id, type: String, desc: "Badge ID"
    end
    post "/grant_me_badge" do
      b = AchievedBadge.create user: current_user, badge: Badge.find(params[:badge_id])
      present :badge, b.badge, with: API::V1::Badges::Entities::Badge
    end
  end

end
    