class Category < ApplicationRecord
  has_many :clusters
  belongs_to :creator, optional: true, class_name: "User"

  validates_presence_of :name
end
