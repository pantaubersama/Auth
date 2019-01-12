FactoryBot.define do
  factory :category do
    name { Faker::FunnyName.name }
    description { Faker::FunnyName.name }
  end
end
