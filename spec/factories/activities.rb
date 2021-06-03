FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.word }
    day { Faker::Date.between(from: DateTime.now, to: '2022-05-08') }
    user
  end
end
