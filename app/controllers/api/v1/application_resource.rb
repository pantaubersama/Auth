module API
  module V1
    class ApplicationResource < Grape::API
      # Pagination
      # paginate per_page: 100, max_per_page: 500

      # Exception Handlers
      include API::V1::ExceptionHandlers

      AUTHORIZATION_HEADERS = { Authorization: { description: 'Access Token', required: true } }.freeze
    end
  end
end
