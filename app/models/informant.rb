class Informant < ApplicationRecord
  belongs_to :user

  after_save :give_achievement

  def is_complete?
    identity_number.present? && pob.present? && dob.present? && gender.present? && occupation.present? && nationality.present? && address.present? && phone_number.present?
  end

  def give_achievement
    if is_complete?
      Badges::Achieve.new.run({user_id: user.id, badge_code: "biodata_lapor"}) 
    end
  end
end
