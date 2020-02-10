FactoryBot.define do
  factory :tweet do
    text {"hello!"}
    image {"hoge.png"}
    created_at { Faker::Time.between( from: 2.days.ago, to: Time.now ) }
    user
  end
end