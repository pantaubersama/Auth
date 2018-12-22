module API::V2::Helpers
  # meta response
  def present_metas resources
    total_pages  = resources.total_pages
    limit_value  = resources.limit_value
    current_page = resources.current_page
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def prepare_file(f)
    ActionDispatch::Http::UploadedFile.new(f)
  end

  def permitted_params(params)
    ActionController::Parameters.new(params)
  end
  
end