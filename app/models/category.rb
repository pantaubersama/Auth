class Category < ApplicationRecord
  has_many :clusters

  validates_presence_of :name
end
