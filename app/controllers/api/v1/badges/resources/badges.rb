module API::V1::Badges::Resources
  class Badges < API::V1::ApplicationResource
    helpers ::API::V1::SharedParams
    helpers API::V1::Helpers

    namespace "badges" do
      desc "List of badges" do
        headers OPTIONAL_AUTHORIZATION_HEADERS
        detail "List of badges <br> If you provide access token you will get achieved badges, this will cause <b>badges - achieved_badges</b> automatically"
      end
      params do
        use :order, order_by: %i(position), default_order_by: :position, default_order: :asc
      end
      paginate
      get "/" do
        existing_badges = []
        existing_badges = current_user.badges if current_user.present?

        default_order = {position: :asc}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order
        badges = Badge.includes(:achieved_badges).visible.order(build_order)
        resources = paginate(badges - existing_badges)

        present :achieved_badges, existing_badges, with: API::V1::Badges::Entities::Badge
        present :badges, resources, with: API::V1::Badges::Entities::Badge
        present_metas resources
      end
    end

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
        default_order = {position: :asc}
        build_order = params.order_by.present? && params.direction.present? ? { params.order_by.to_sym => params.direction.to_sym } : default_order
        badges = current_user.badges.order(build_order)
        resources = paginate(badges)

        present :badges, resources, with: API::V1::Badges::Entities::Badge
        present_metas resources
      end
    end

  end
end