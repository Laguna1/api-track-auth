FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'testuser@mail.com' }
    password { 'testuser' }
  end
end
