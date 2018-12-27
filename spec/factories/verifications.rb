FactoryBot.define do
  factory :verification do
    user_id { "" }
    ktp_number { "MyString" }
    ktp_photo { "MyString" }
    ktp_selfie { "MyString" }
    signature { "MyString" }
  end
end
