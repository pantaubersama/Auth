module API
  module V1
    class InternalResource < Grape::API
      # Pagination
      # paginate per_page: 25, max_per_page: 500

      # Exception Handlers
      include API::V1::ExceptionHandlers
      
      # Including this headers will automatically make the endpoint internal
      INTERNAL_API_HEADERS = { PantauAuthKey: { description: 'Pantau Auth Key to access internal API', required: true } }.freeze
    end
  end
end
