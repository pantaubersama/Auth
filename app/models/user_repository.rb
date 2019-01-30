class UserRepository
  include Elasticsearch::Persistence::Repository
  include Elasticsearch::Persistence::Repository::DSL

  index_name 'user_cache'
  document_type 'user_cache'
  klass UserCache

  def create(params)
    save(params)
  end
end
