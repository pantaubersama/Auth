module API::V1::Badges::Resources
  class User < API::V1::ApplicationResource
    helpers ::API::V1::SharedParams
    helpers API::V1::Helpers

    # protected
    namespace "badges" do
      desc "List achieved badges by user" do
        headers OPTIONAL_AUTHORIZATION_HEADERS
        detail "List achieved badges by user"
      end
      params do
        use :order, order_by: %i(position), default_order_by: :position, default_order: :asc
      end
      paginate
      get "/user/:id" do
        user = ::User.find params.id
        existing_badges = []
        existing_badges = user.achieved_badges if user.present?

        default_order = {position: :asc}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order
        badges = Badge.includes(:achieved_badges).visible.order(build_order)
        resources = paginate(badges - existing_badges.map(&:badge))

        present :achieved_badges, existing_badges, with: API::V1::Badges::Entities::AchievedBadge, current_user: current_user
        present :badges, resources, with: API::V1::Badges::Entities::Badge, current_user: current_user
        present_metas resources
      end
    end

  end
end