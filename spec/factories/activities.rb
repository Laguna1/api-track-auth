FactoryBot.define do
    factory :activity do
      name { Faker::Lorem.word }
      day { DateTime.now }
      user
    end
end