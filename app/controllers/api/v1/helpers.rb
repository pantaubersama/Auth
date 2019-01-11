module API::V1::Helpers
  # meta response
  def present_metas resources
    total_pages  = resources.count
    limit_value  = params.per_page
    current_page = params.page
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def authorize_admin!
    error!("Tidak dapat mengakses API", 403) if current_user.nil? || !current_user.is_admin?
  end

  def authorize_moderator! cluster
    error!("Tidak dapat mengakses API. Anda bukan moderator!", 403) unless current_user.has_role?(:moderator, cluster)
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

  def user_filter(x)
    case x
    when "verified_true"
      { "verified" => true }
    when "verified_false"
      { "verified" => false }
    when "verified_all"
      {}
    else
      {}
    end
  end
  
end