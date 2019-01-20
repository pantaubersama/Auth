class AchievedBadge < ApplicationRecord
  belongs_to :badge
  belongs_to :user, touch: true
  belongs_to :resource, polymorphic: true, optional: true

  validates :badge, uniqueness: { scope: :user }
end
