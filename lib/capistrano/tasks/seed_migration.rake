namespace :deploy do
  task :seed_migrating do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "seed:migrate"
        end
      end
    end
  end
end