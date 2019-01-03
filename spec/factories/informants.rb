FactoryBot.define do
  factory :informant do
    identity_number { Faker::IDNumber.valid }
    pob { Faker::Lorem.words(2) }
    dob { Faker::Date }
    gender { 1 }
    occupation { Faker::Lorem.words(2) }
    nationality { Faker::Lorem.words(2) }
    address { Faker::Lorem.words(5) }
    phone_number { Faker::PhoneNumber.cell_phone }
    association :user
  end
end
