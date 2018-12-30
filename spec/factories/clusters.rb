FactoryBot.define do
  factory :cluster do
    name { Faker::FunnyName.name }
    description { Faker::Lorem.words(4) }
    category { FactoryBot.create :category }
  end
end
