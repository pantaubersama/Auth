class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def index_all
    results = {}
    (self.attributes.keys.delete_if { |x| [:deleted_at, "deleted_at"].include?(x) }).each do |column|
      results[column] = self.send(column.to_s)
    end
    results
  end

end
