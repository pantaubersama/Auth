class FirebaseKey < ApplicationRecord
  enum key_type: [ :android, :ios, :web ]

  belongs_to :user

  def self.assign! user_id, tipe, content
    firebase = FirebaseKey.where(user_id: user_id, key_type: FirebaseKey.key_types[tipe]).first_or_create! do |f|
      f.content = content
    end
    firebase.update_attribute(:content, content)
    firebase
  end
  
end
