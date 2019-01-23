module Badges
  class Achieve

    def run params
      # user_id : UUID
      # badge_code : code
      # Badges::Achieve.new.run({user_id: "UUID", badge_code: "CODE"})
      badge = Badge.find_by code: params[:badge_code]
      user = User.find_by id: params[:user_id]
      AchievedBadge.create(user: user, badge: badge)
    end
    
  end
end