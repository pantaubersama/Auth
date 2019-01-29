class UserCache
  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = attributes
  end

  def to_hash
    @attributes
  end

  def self.find id
    user = UserRepository.new.find(id)
    ParseResponse.new(user.attributes) if user.present?
  end
end
