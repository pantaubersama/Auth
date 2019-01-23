module Badges
  class Question

    def run params
      user = User.find params[:user_id]      
      if user
        [1, 10, 30, 50].each do |achievement|
          badge = Badge.find_by code: params[:badge_code].to_s + achievement.to_s
          AchievedBadge.create(user: user, badge: badge) if params[:total] >= achievement
        end
      end
    end
    
  end
end