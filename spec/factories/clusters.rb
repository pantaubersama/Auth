FactoryBot.define do
  factory :cluster do
    name { "#{Faker::FunnyName.name} Valen"  }
    description { Faker::Lorem.words(4) }
    category { FactoryBot.create :category }
    is_displayed { false }
  end
end
