module API::V1::Badges::Resources
  class Badges < API::V1::ApplicationResource
    helpers ::API::V1::SharedParams
    helpers API::V1::Helpers

    # optional
    namespace "badges" do
      desc "List of badges" do
        headers OPTIONAL_AUTHORIZATION_HEADERS
        detail "List of badges <br> If you provide access token you will get achieved badges, this will cause <b>badges - achieved_badges</b> automatically"
      end
      params do
        use :order, order_by: %i(position), default_order_by: :position, default_order: :asc
        optional :name, type: String, desc: "Name Badge"
      end
      paginate
      get "/" do
        existing_badges = []
        existing_badges = current_user.achieved_badges if current_user.present?

        default_order = {position: :asc}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order
        badges = Badge.includes(:achieved_badges).visible.order(build_order).where("lower(name) LIKE lower(?)", "%#{params.name}%")
        resources = paginate(badges - existing_badges.map(&:badge))

        present :achieved_badges, existing_badges, with: API::V1::Badges::Entities::AchievedBadge, current_user: current_user
        present :badges, resources, with: API::V1::Badges::Entities::Badge, current_user: current_user
        present_metas resources
      end

      desc 'Find' do
        detail "Find"
      end
      params do
        requires :id, type: String
      end
      get "/:id" do
        present :badge, Badge.find(params[:id]), with: API::V1::Badges::Entities::Badge, current_user: current_user
      end
    end

    # protected
    namespace "me" do
      desc "Achieved badges" do
        headers AUTHORIZATION_HEADERS
        detail "Achieved badges"
      end
      params do
        use :order, order_by: %i(position), default_order_by: :position, default_order: :asc
      end
      paginate
      oauth2
      get "/badges" do
        default_order = "badges.position asc"
        build_order = params.order_by.present? && params.direction.present? ? "badges.#{params.order_by} #{params.direction}" : default_order
        achieved_badges = current_user.achieved_badges.joins(:badge, :user).order(build_order)
        resources = paginate(achieved_badges)

        present :achieved_badges, resources, with: API::V1::Badges::Entities::AchievedBadge, current_user: current_user
        present_metas resources
      end
    end

  end
end