if Rails.env.development?
  ActiveSupport::Dependencies.explicitly_unloadable_constants << 'API::Init'

  api_files = Dir[Rails.root.join('app','controllers', 'api', '**', '*.rb')]
  api_reloader = ActiveSupport::FileUpdateChecker.new(api_files) do
    Rails.application.reload_routes!
  end
  ActiveSupport::Reloader.to_prepare do
    api_reloader.execute_if_updated
  end
end