FactoryBot.define do
  factory :informant do
    user_id { "" }
    identity_number { "MyString" }
    pob { "MyString" }
    dob { "MyString" }
    gender { 1 }
    occupation { "MyString" }
    nationality { "MyString" }
    address { "MyText" }
    phone_number { "MyString" }
  end
end
