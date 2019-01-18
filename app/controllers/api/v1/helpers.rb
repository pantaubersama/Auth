module API::V1::Helpers
  def present_metas resources
    total_pages  = resources.total_pages
    limit_value  = params.limit_value || params.per_page || Pagy::VARS[:max_per_page]
    current_page = params.current_page || params.page || 1
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def present_metas_searchkick resources
    total_pages  = (resources.total_count.to_f / (params.per_page || Pagy::VARS[:max_per_page])).ceil
    limit_value  = params.per_page || Pagy::VARS[:max_per_page]
    current_page = params.page || 1
    present :meta, { total_pages: total_pages, limit_value: limit_value, current_page: current_page }, with: API::V1::Metas::Entities::Meta
  end

  def authorize_admin!
    error!("Tidak dapat mengakses API. Anda bukan admin!", 403) if current_user.nil? || !current_user.is_admin?
  end

  def authorize_moderator! cluster
    error!("Tidak dapat mengakses API. Anda bukan moderator!", 403) unless current_user.has_role?(:moderator, cluster)
  end

  def authorize_moderator_or_admin! cluster
    authorize_moderator! cluster unless current_user.is_admin?
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