FactoryBot.define do
  factory :wordstadium_challenge, class: 'Wordstadium::Challenge' do
    invite_code { "MyString" }
    twitter_uid { nil }
    user_id { nil }
  end
end
