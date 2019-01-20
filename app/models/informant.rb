class Informant < ApplicationRecord
  belongs_to :user, touch: true
end
