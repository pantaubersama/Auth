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
        "", "janji_politik", "tanya", "tanya_interaksi", "kuis", "lapor",
        "profile", "relawan", "pantau_bersama"
      ].freeze
    end
  end
end
