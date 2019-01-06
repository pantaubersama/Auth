module API::V1::Badges::Resources
  class AchievedBadges < API::V1::ApplicationResource
    helpers ::API::V1::SharedParams
    helpers API::V1::Helpers

    resource "achieved_badges" do

      desc 'Find by achieved ID' do
        detail "Find by achieved ID"
      end
      params do
        requires :id, type: String
      end
      get "/:id" do
        present :achieved_badge, AchievedBadge.find(params[:id]), with: API::V1::Badges::Entities::AchievedBadge
      end
      
    end

  end
end