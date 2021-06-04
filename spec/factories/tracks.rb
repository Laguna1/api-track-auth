FactoryBot.define do
  factory :track do
    distance { Faker::Number.number(digits: 6) }
    duration { Faker::Number.number(digits: 3) }
    name { Faker::Lorem.word }
    activity
  end
end
