module API
  module V1
    class ApplicationResource < Grape::API
      # Pagination
      # paginate per_page: 25, max_per_page: 500

      # Exception Handlers
      include API::V1::ExceptionHandlers

      AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: true } }.freeze
      OPTIONAL_AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: false } }.freeze

      BADGE_NAMESPACE = [
        "", "badge_janji_politik", "badge_tanya", "badge_tanya_interaksi", "badge_kuis", "badge_lapor",
        "badge_profile", "badge_relawan", "badge_pantau_bersama"
      ].freeze
    end
  end
end
