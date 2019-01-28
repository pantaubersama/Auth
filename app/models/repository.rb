require 'elasticsearch/persistence'
class Repository
  include Elasticsearch::Persistence::Repository

  def create(params)
    save(params)
  end

end
