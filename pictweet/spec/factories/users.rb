FactoryBot.define do
  factory :user do
    nickname              {"abc"}
    sequence(:email)      {Faker::Internet.email} # 適当なメールアドレスを作るGemから生成
    password              {"00000000"}
    password_confirmation {"00000000"}
  end
end