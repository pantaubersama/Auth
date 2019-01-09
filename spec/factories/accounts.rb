FactoryBot.define do
  factory :account do
    account_type { 1 }
    access_token { "MyText" }
    access_token_secret { "MyText" }
    uid { "MyString" }
    email { "MyString" }
  end
end
