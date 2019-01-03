FactoryBot.define do
  factory :firebase_key do
    content { Faker::Lorem.sentence(5) }
    key_type { "ios" }
    user_id { "" }
  end
end
