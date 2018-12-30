FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    provider { "identitas" }
    uid { Random.rand(1000) }
  end
end
