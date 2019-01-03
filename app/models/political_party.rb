class PoliticalParty < ApplicationRecord
  mount_uploader :image, PoliticalPartyUploader
end
