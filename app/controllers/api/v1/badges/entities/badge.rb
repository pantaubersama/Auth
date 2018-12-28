module API::V1::Badges::Entities
  class Badge < Grape::Entity
    expose :id
    expose :name
    expose :description
    expose :image
    expose :position
    # expose :is_claimed, if: lambda { |c,o| o[:current_user].nil? } 
    # expose :achieved_badges, as: :is_claimed, if: lambda { |c,o| o[:current_user].present? } do |c,o|
    #   c.achieved_badges.where(user: o[:current_user]).last.present?
    # end

    # def is_claimed
    #   false
    # end
    
  end
end