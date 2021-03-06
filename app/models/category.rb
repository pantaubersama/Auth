class Category < ApplicationRecord
  has_many :clusters
  belongs_to :creator, optional: true, class_name: "User"

  validates_presence_of :name
  validates_length_of :description, minimum: 3, maximum: 255, allow_nil: true
end
