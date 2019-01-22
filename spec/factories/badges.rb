FactoryBot.define do
  factory :badge do
    name { Faker::FunnyName.name }
    description { Faker::Lorem.words(4) }
    image { nil }
    star { 1 }
    position { 1 }
    code { Faker::FunnyName.name }
    namespace { Faker::FunnyName.name }
  end
end
