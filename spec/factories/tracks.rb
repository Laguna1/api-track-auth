FactoryBot.define do
  factory :track do
    distance { Faker::Number.number(digits: 4) }
    rate { Faker::Lorem.word }
    activity
  end
end
